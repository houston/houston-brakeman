require "houston/brakeman/engine"
require "houston/brakeman/configuration"

module Houston
  module Brakeman
    extend self

    def config(&block)
      @configuration ||= Brakeman::Configuration.new
      @configuration.instance_eval(&block) if block_given?
      @configuration
    end

  end
end
