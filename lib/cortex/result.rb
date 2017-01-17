module Cortex
  class Result
    attr_reader :raw_headers, :contents, :total_items, :page, :per_page, :errors, :range_start, :range_end, :range, :status, :total_pages, :next_page, :prev_page

    def initialize(body, headers, status)
      @contents = body
      @raw_headers = headers
      @status = status
      parse_headers(headers)
      @errors = find_errors
    end

    def is_error?
      @status >= 400 || (@contents.is_a?(Hash) && @contents.errors?)
    end

    private

    def parse_headers(headers)
      if headers['X-Total']
        @total_items = headers['X-Total']
        @count = headers['X-Total'].to_i
        @page = headers['X-Page'].to_i
        @per_page = headers['X-Per-Page'].to_i
        @range_start = (@page-1) * @per_page
        @range_end = @per_page * @page - 1
        @range = "#{@range_start}-#{@range_end}"
        @total_pages = headers['X-Total-Pages']
        @next_page = headers['X-Next-Page']
        @prev_page = headers['X-Prev-Page']
      end
    end

    def find_errors
      errors = nil
      if is_error?
        if @contents.is_a?(Hash)
          if @contents.errors?
            errors = @contents.errors
          else
            errors = @contents.message
          end
        else
          errors = @contents
        end
      end

      Array(errors)
    end
  end
end
