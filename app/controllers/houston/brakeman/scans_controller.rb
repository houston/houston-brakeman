module Houston
  module Brakeman
    class ScansController < ApplicationController

      def create
        project = Project.find_by_slug! params[:project_slug]
        scan = Scan.find_or_create_by!(project: project, sha: params[:sha])
        scan.update_results! request.raw_post
        head :ok
      end

    end
  end
end
