require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "root renders marketing shell" do
    get root_url
    assert_response :success
    assert_select "h1", /Rails 7 \+ Tailwind foundation/
  end
end
