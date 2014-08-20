module Cortex
  class Result
    attr_reader :raw_headers, :contents, :total_items, :page, :per_page

    def initialize(body, headers, status)
      @contents = body
      @raw_headers = headers
      @status = status
      @total_items = headers['x-total-items'] unless headers['x-total-items'].nil?
      parse_headers(headers)
    end

    def is_error?
      @status >= 400
    end

    private

    def parse_headers(headers)
      if headers['x-total-items']
        @count = headers['x-total-items']
      end
      if headers['content-range']
        matches = headers['content-range'].match(/^(\w+) (\d+)\-(\d+):(\d+)\/\d+$/i)
        @per_page = matches[4]
        range_end = matches[3]
        @page = (range_end.to_i / @per_page.to_i) + 1
      end
    end
  end
end