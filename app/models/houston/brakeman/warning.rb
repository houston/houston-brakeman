module Houston
  module Brakeman
    class Warning < ActiveRecord::Base
      self.table_name = "brakeman_warnings"

      belongs_to :project

      validates :project_id,
                :warning_type,
                :warning_code,
                :fingerprint,
                :message,
                :file,
                :url,
                :confidence,
                presence: true

      def link=(value)
        self.url = value
      end

      def self.find_or_create_for(warning)
        create_with(warning).find_or_create_by!(fingerprint: warning["fingerprint"])
      rescue ActiveRecord::RecordNotUnique
        find_by(fingerprint: warning["fingerprint"])
      end

    end
  end
end
