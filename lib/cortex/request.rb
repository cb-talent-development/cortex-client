require 'ostruct'

module Cortex
  module Request
    def get(path, params = {})
      response = connection.get do |r|
        r.url base_url + path
        r.params = params
      end
      parse_response(response)
    end

    def post(path, params = {})
      response = connection.post do |r|
        r.url base_url + path
        r.body = params unless params.empty?
      end
      parse_response(response)
    end

    def put(path, params = {})
      response = connection.put do |r|
        r.url base_url + path
        r.body = params unless params.empty?
      end
      parse_response(response)
    end

    def delete(path)
      response = connection.delete do |r|
        r.url base_url + path
      end
      parse_response(response)
    end

    def delete!(path)
      response = connection.delete do |r|
        r.url base_url + path
      end
      if response.status < 300
        true
      else
        raise parse_response(response)
      end
    end

    def save(path, model)
      model[:id] ? put("#{path}/#{model[:id]}", model) : post(path, model)
    end

    def parse_response(response)
      # if response.status < 300 || (response.body.kind_of?(Hash) && response.body['error'])
      #   OpenStruct.new({body: response.body, headers: { status: response.status }.merge(response.headers.select { |k| ['content-range', 'x-total-items'].include? k })  })
      # else
      #   OpenStruct.new({body: {error: response.body, status: response.status, original: response}, headers: { status: response.status }})
      # end
      Cortex::Result.new(response.body, response.headers, response.status)
    end
  end
end
