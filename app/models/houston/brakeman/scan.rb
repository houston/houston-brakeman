module Houston
  module Brakeman
    class Scan < ActiveRecord::Base
      self.table_name = "brakeman_scans"
      include BelongsToCommit

      belongs_to :project
      has_and_belongs_to_many :warnings

      def update_results!(results)
        results = MultiJson.load(results) if results.is_a?(String)

        transaction do
          scan_info = results["scan_info"]
          update_attributes!(
            brakeman_version: scan_info["brakeman_version"],
            duration: (scan_info["duration"] * 1000).round,
            checks_performed: scan_info["checks_performed"])

          self.warnings = results["warnings"].map do |warning|
            Houston::Brakeman::Warning.where(project_id: project_id)
              .create_with(warning)
              .find_or_create_by(fingerprint: warning["fingerprint"])
          end
        end

        Houston.observer.fire "brakeman:scan:complete", self
      end

      def state
        warnings.any? ? "failure" : "success"
      end

      def context
        "brakeman"
      end

      def url
        "https://#{Houston.config.host}/brakeman/scans/#{project.slug}/#{sha}"
      end

      def description
        if warnings.any?
          "#{warnings.count} warnings"
        else
          "all clear!"
        end
      end

    end
  end
end
