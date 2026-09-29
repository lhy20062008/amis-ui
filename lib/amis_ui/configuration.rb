# frozen_string_literal: true

module AmisUi
  class Configuration
    attr_reader :cms_path

    def initialize
      @cms_path = "/cms"
    end

    def cms_path=(path)
      normalized_path = path.to_s.strip.sub(%r{\A/+}, "").sub(%r{/+\z}, "")
      @cms_path = "/#{normalized_path}"
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
