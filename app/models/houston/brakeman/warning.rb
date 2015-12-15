module Houston
  module Brakeman
    class Warning < ActiveRecord::Base
      self.table_name = "brakeman_warnings"

      belongs_to :project

      def link=(value)
        self.url = value
      end

    end
  end
end
