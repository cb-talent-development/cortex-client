module Cortex
  module Client
    class Response
      attr_reader :status, :headers, :body

      def initialize(status, headers, body=nil) # Mimic Rack
        @status = status
        @headers = headers
        @body = body
        @content_range = @headers.has_key?(:'content-range') ? @headers[:'content-range'].match(/^(\w+) (\d+)\-(\d+):(\d+)\/\d+$/) : Array.new(4)
      end

      def success?
        @status < 400 || @contents.has_key?(:errors)
      end

      def failure?
        !success?
      end

      def errors # This is ugly, ugly, ugly. Let's figure out something better
        @errors ||= begin
          if failure?
            if @body.is_a?(Hash)
              if @body.has_key?(:errors)
                Array(@body[:errors])
              else
                Array(@body[:message])
              end
            else
              Array(@contents)
            end
          else
            Array(nil)
          end
        end
      end

      def total
        @headers[:'x-total-items'] || 1
      end

      def page
        begin
          (@content_range[2].to_i / @content_range[3].to_i) + 1
        rescue ZeroDivisionError => e
          1
        end
      end

      def per_page
        @content_range[3] || 1
      end
    end
  end
end