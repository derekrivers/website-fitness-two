require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "root renders complete FitnessFormula marketing page" do
    get root_url
    assert_response :success

    headings = [
      "Fitness that fits real life in Scotland",
      "Personal Training",
      "Group Classes",
      "Nutrition Coaching",
      "Training Videos",
      "Client Results",
      "Book Your FitnessFormula Session"
    ]

    headings.each do |heading|
      assert_select "h1,h2", text: heading
    end

    rendered = @response.body
    assert headings.each_cons(2).all? { |first, second| rendered.index(first) < rendered.index(second) }
    assert_includes rendered, "Book a session"
    assert_includes rendered, "data-future-src=\"https://fitnessformula-assets.ams3.digitaloceanspaces.com/videos/personal-training-intro.mp4\""
  end
end
