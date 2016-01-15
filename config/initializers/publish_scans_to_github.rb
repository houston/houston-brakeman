Houston.observer.on "test_run:start" do |test_run|
  test_run.commit.publish_commit_status! state: "pending", context: "brakeman"
end

Houston.config.on "brakeman:scan:complete" do |scan|
  begin
    repo = scan.project.repo
    return unless repo.respond_to? :create_commit_status
    repo.create_commit_status(scan.sha, scan)

  rescue Exception # rescues StandardError by default; but we want to rescue and report all errors
    Houston.report_exception $!, parameters: {
      brakeman_scan_id: scan.id,
      project: scan.project.slug,
      method: "publish_status_to_github" }
  end
end
