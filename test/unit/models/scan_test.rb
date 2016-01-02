require "test_helper"

class ScanTest < ActiveSupport::TestCase
  attr_reader :test, :commit, :scan


  setup do
    @test = Project["test"]
    @commit = test.commits.create!(
      sha: "example-sha",
      message: "nothing to see here",
      authored_at: Time.now,
      committer: "Houston",
      committer_email: "commitbot@houston.com")
  end


  context "A new scan" do
    setup do
      @scan = Houston::Brakeman::Scan.create!(
        project_id: test.id,
        sha: "example-sha")
    end

    should "be associated with a commit" do
      assert_equal commit, scan.commit
    end

    context "#update_results!" do
      should "store data about the scan itself" do
        scan.update_results! brakeman_example
        assert_equal "3.1.2", scan.brakeman_version
        assert_equal 3797, scan.duration
        assert scan.checks_performed.length > 0
      end

      should "create records of each warning" do
        assert_difference "Houston::Brakeman::Warning.count", +15 do
          scan.update_results! brakeman_example
        end
      end

      should "publish results to GitHub" do
        mock(test.repo).create_commit_status("example-sha", anything)
        scan.update_results! brakeman_example
      end
    end
  end


private

  def brakeman_example
    MultiJson.load File.read("test/data/example.json")
  end

end
