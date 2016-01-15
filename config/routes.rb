Houston::Brakeman::Engine.routes.draw do

  put "brakeman/scans/:project_slug/:sha", to: "scans#create"
  get "brakeman/scans/:project_slug/:sha", to: "scans#show"

  scope "projects/:project_slug/commits/:sha" do
    get "brakeman_scan", to: "scans#show"
  end

  scope "projects/:project_slug/:sha", constraints: {sha: /[a-f0-9]{40}/} do
    get "brakeman_scan", to: "scans#show"
  end

end
