Houston::Brakeman::Engine.routes.draw do

  put "brakeman/scans/:project_slug/:sha", to: "scans#create"

end
