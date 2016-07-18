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



  register_events {{
    "brakeman:scan:complete" => params("scan").desc("A Brakeman scan has completed and the results are recorded")
  }}

end
