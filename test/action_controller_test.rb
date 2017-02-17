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

    def archive
      redirect_to "/"
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

  def test_callbacks
    controller = TestController.new
    controller.response = []

    controller.process :show

    assert_equal ["before callback", "show", "after callback"],
      controller.response
  end

  class Request
    def params
      { "id" => 1}
    end
  end

  def test_posts_controller
    controller = PostsController.new
    controller.request = Request.new

    controller.process :show
  end

  class Response
    attr_accessor :status, :location, :body
  end

  def test_redirecting
    controller = TestController.new
    controller.response = Response.new

    controller.process :archive

    assert_equal 302, controller.response.status
    assert_equal "/", controller.response.location
    assert_equal ["Redirecting..."], controller.response.body
  end

end
