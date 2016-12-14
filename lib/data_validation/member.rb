class DataValidation
  class Member
    attr_reader :address, :analysis

    def initialize(address, analysis)
      @address = address
      @analysis = analysis
    end
  end
end
