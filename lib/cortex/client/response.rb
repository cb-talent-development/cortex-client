module Cortex
  module Client
    class Response
      attr_reader :status, :headers, :body

      def initialize(status, headers, body=nil) # Mimic Rack
        @status = status
        @headers = headers
        @body = body
        @content_range = @headers[:'content-range'].match(r{^(\w+) (\d+)\-(\d+):(\d+)\/\d+$}) || Array.new(4)
      end

      def success?
        @status < 400 || @contents.has_key? :errors
      end

      def failure?
        !success?
      end

      def errors # This is ugly, ugly, ugly. Let's figure out something better
        @errors ||= do
          if failure?
            if @body.is_a?(Hash)
              if @body.has_key? :errors
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
        @headers[:'x-total-items']
      end

      def page
        @content_range[2] / @content_range[3] + 1
      end

      def per_page
        @content_range[3]
      end

    end
  end
end