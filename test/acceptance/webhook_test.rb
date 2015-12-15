require "test_helper"

class WebhookTest < ActionDispatch::IntegrationTest


  context "POST /hooks/brakeman" do
    should "parse the payload and create warnings" do
      assert_difference "Houston::Brakeman::Warning.count", +15 do
        put "/brakeman/scans/test/89e6694e958ca96c89841f6cf0befd825baf81ed", brakeman_example,
          {"CONTENT_TYPE" => "application/json"}
      end
    end
  end


private

  def brakeman_example
    File.read "test/data/example.json"
  end

end
