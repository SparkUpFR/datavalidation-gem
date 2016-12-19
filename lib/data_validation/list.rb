require 'csv'
require 'data_validation/error'
require 'data_validation/member'
require 'data_validation/job'

class DataValidation
  class List
    attr_reader :slug

    def self.create(api, members)
      list = DataValidation::List.new(api)
      list.create(members)
      list
    end

    def self.get(api, slug)
      list = DataValidation::List.new(api)
      list.get(slug)
      list
    end

    def create_job
      DataValidation::Job.create(@api, self)
    end

    def get_job(slug)
      DataValidation::Job.get(@api, self, slug)
    end

    def members
      data = []
      response = @api.get("list/#{@slug}/export.csv")
      if @api.valid_response?(response)
        body = response.body
        CSV.parse(body) do |row|
          address = row[1]
          analysis = {}
          analysis['grade']     = row[2]
          analysis['click']     = row[3]
          analysis['open']      = row[4]
          analysis['hard']      = row[5]
          analysis['optout']    = row[6]
          analysis['complain']  = row[7]
          analysis['trap']      = row[8]
          analysis['deceased']  = row[9]
          data << DataValidation::Member.new(address, analysis)
        end
      else
        raise DataValidation::Error, "could not get members for list #{@slug}"
      end
      data
    end

    def initialize(api)
      @api = api
      @slug = nil
    end

    def create(members)
      data = members.map{|m| m + ",\n"}.join()
      response = @api.post("list/?header=false&email=0&metadata=false", data, { 'Content-Type' => 'text/csv' })
      if @api.valid_response?(response)
        raw = JSON.parse(response.body)
        raw_list = raw["list"][0]
        @slug = raw_list["slug"]
      else
        raise DataValidation::Error, "could not create list"
      end
    end

    def get(slug)
      @slug = slug
    end
  end
end
