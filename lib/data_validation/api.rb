require 'httparty'
require 'json'

class DataValidation
  class API
    BASE_URI = "https://api.datavalidation.com/1.0"

    attr_reader :key

    def initialize(key)
      @key = key
    end

    def get(uri, h = {})
      HTTParty.get("#{BASE_URI}/#{uri}", headers: headers.merge(h))
    end

    def post(uri, body = nil, h = {})
      q = {}
      q[:body] = body unless body.nil?
      q[:headers] = headers.merge(h)
      HTTParty.post("#{BASE_URI}/#{uri}", q)
    end

    def valid_response?(response)
      code = response.code
      code >= 200 && code <= 299
    end

    private
    def headers
      {
        'Authorization' => "bearer #{@key}"
      }
    end
  end
end
