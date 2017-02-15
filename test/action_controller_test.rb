require "test_helper"

class ActionControllerTest < Minitest::Test
  class TestController < ActionController::Base
    before_action :before_callback, only: [:show]
    after_action  :after_callback,  only: [:show]

    def index
      response << "index"
    end

    def show
      response << "show"
    end

    private

    def before_callback
      response << "before callback"
    end

    def after_callback
      response << "after callback"
    end
  end

  def test_calls_index_action
    controller = TestController.new
    controller.response = []

    controller.process :index

    assert_equal ["index"], controller.response
  end

  def test_before_callbacks
    controller = TestController.new
    controller.response = []

    controller.process :show

    assert_equal ["before callback", "show", "after callback"],
      controller.response
  end

end
