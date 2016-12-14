require 'data_validation/version'
require 'data_validation/api'
require 'data_validation/list'

class DataValidation
  def initialize(key)
    @api = DataValidation::API.new(key)
  end

  def create_list(members)
    DataValidation::List.create(@api, members)
  end

  def get_list(slug)
    DataValidation::List.get(@api, slug)
  end
end
