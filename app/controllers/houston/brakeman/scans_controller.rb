module Houston
  module Brakeman
    class ScansController < ApplicationController
      attr_reader :project
      before_action :find_project
      skip_before_action :verify_authenticity_token, only: [:create]

      def show
        @scan = Scan.find_by!(project_id: project.id, sha: params[:sha])
      end

      def create
        unless request.raw_post.blank?
          scan = Scan.find_or_create_by!(project: project, sha: params[:sha])
          scan.update_results! request.raw_post
        end
        head :ok
      end

private

      def find_project
        @project = Project.find_by_slug! params[:project_slug]
      end

    end
  end
end
