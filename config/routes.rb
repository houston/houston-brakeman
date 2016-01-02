Houston::Brakeman::Engine.routes.draw do

  put "brakeman/scans/:project_slug/:sha", to: "scans#create"
  get "brakeman/scans/:project_slug/:sha", to: "scans#show"

end
