# Houston::Brakeman

Processes and saves Brakeman scan data for commits


## Installation

In your `Gemfile`, add:

    gem "houston-brakeman"

And in `config/main.rb`, add:

```ruby
use :brakeman

on "brakeman:scan:complete" do |scan|
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
```

And then execute:

    $ bundle


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
