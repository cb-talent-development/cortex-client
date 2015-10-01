require 'hashie'
module Cortex
  class Result
    attr_reader :raw_headers, :contents, :total_items, :page, :per_page, :errors, :range_start, :range_end, :range, :status

    def initialize(body, headers, status)
      @contents = parse(body)
      @raw_headers = headers
      @status = status
      @total_items = headers['x-total-items'] unless headers['x-total-items'].nil?
      parse_headers(headers)
      @errors = find_errors
    end

    def is_error?
      @status >= 400 || (@contents.is_a?(Hash) && @contents.has_key?('errors'))
    end

    private

    def parse_headers(headers)
      if headers['X-Total']
        @count = headers['X-Total'].to_i
      end
      if headers['X-Total']
        @page = headers['X-Page'].to_i
        @per_page = headers['X-Per-Page'].to_i
        @range_start = (@page-1) * @per_page
        @range_end = @per_page * @page - 1
        @range = "#{@range_start}-#{@range_end}"

      end
    end

    def parse(body)
      case body
        when Hash
          ::Hashie::Mash.new(body)
        when Array
          body.map { |item| parse(item) }
        else
          body
      end
    end

    def find_errors
      if is_error?
        if @contents.is_a?(Hash)
          if @contents.has_key?('errors')
            Array(@contents['errors'])
          else
            Array(@contents['message'])
          end
        else
          Array(@contents)
        end
      else
        Array(nil)
      end
    end
  end
end