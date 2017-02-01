require "test_helper"

class ActiveSupportTest < Minitest::Test
  def test_search_for_file
    file = ActiveSupport::Dependecies.search_for_file("application_controller")
    assert_equal "#{__dir__}/blog/app/controllers/application_controller.rb",
      file

    file = ActiveSupport::Dependecies.search_for_file("unknown")
    assert_equal nil, file
  end

  def test_case_name
    assert_equal "post", "Post".underscore
    assert_equal "application_controller", "ApplicationController".underscore
  end

  def test_loading_missing_constants
    Post
  end
end
