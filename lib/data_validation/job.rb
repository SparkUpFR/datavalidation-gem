class DataValidation
  class Job
    attr_reader :slug

    def self.create(api, list)
      job = DataValidation::Job.new(api, list)
      job.create
      job
    end

    def self.get(api, list, slug)
      job = DataValidation::Job.new(api, list)
      job.get(slug)
      job
    end

    def initialize(api, list)
      @api = api
      @list = list
      @slug = nil
    end

    def create
      response = @api.post("list/#{@list.slug}/job/")
      if @api.valid_response?(response)
        raw = JSON.parse(response.body)
        raw_job = raw["job"][0]
        @slug = raw_job["slug"]
      else
        p response
        raise DataValidation::Error, "could not create job for list #{@list.slug}"
      end
    end

    def get(slug)
      @slug = slug
    end

    def done?
      response = @api.get("list/#{@list.slug}/job/#{@slug}/")
      if @api.valid_response?(response)
        raw = JSON.parse(response.body)
        raw_job = raw["job"][0]
        raw_pct = raw_job["pct_complete"]
        return raw_pct == 100
      else
        raise DataValidationError, "could not check job progress for list #{@list.slug}, job #{@job.slug}"
      end
    end
  end
end
