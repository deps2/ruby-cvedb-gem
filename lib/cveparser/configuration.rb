module FIDIUS::CveDb::Configuration
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :min_year_fetch, :fetch_products_filter

    def initialize
      @min_year_fetch = 2010
      @fetch_products_filter = %w(iphone_os android)
    end
  end
end
