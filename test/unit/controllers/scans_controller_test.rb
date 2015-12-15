require "test_helper"

class ScansControllerTest < ActionController::TestCase

  setup do
    @controller = Houston::Brakeman::ScansController.new
    @routes = Houston::Brakeman::Engine.routes
  end


  context "Given a commit and the output from brakeman, it" do
    should "find the scan" do
      mock(Houston::Brakeman::Scan)
        .find_or_create_by!(project: projects(:test), sha: "89e6694e958ca96c89841f6cf0befd825baf81ed")
        .returns(stub!.update_results!(anything))

      request.env["RAW_POST_DATA"] = brakeman_example
      put :create, {project_slug: "test", sha: "89e6694e958ca96c89841f6cf0befd825baf81ed"}
    end

    should "record the results" do
      scan = Houston::Brakeman::Scan.new
      stub(Houston::Brakeman::Scan)
        .find_or_create_by!(project: projects(:test), sha: "89e6694e958ca96c89841f6cf0befd825baf81ed")
        .returns(scan)
      mock(scan).update_results!(brakeman_example)

      request.env["RAW_POST_DATA"] = brakeman_example
      put :create, {project_slug: "test", sha: "89e6694e958ca96c89841f6cf0befd825baf81ed"}
    end
  end


private

  def brakeman_example
    File.read("test/data/example.json")
  end

end
