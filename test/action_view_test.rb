require "test_helper"

class ActiveViewTest < Minitest::Test
  def test_template_render
    template = ActionView::Template.new("<p>Yo</p>", "test_template")
    context = ActionView::Base.new

    assert_equal "<p>Yo</p>", template.render(context)
  end

  def test_render_with_vars
    template = ActionView::Template.new("<p><%= @var %></p>", "test_template_var")
    context = ActionView::Base.new var: "Yo"

    assert_equal "<p>Yo</p>", template.render(context)
  end

  def test_render_with_yield
    template = ActionView::Template.new("<p><%= yield %></p>", "test_template_yield")
    context = ActionView::Base.new

    assert_equal "<p>yielding</p>", template.render(context) { "yielding" }
  end

  def test_render_with_helpers
    template = ActionView::Template.new("<%= link_to 'test', '/url' %>", "test_template_helper")
    context = ActionView::Base.new

    assert_equal "<a href=\"/url\">test</a>", template.render(context)
  end

  def test_find_template
    file = "#{__dir__}/blog/app/views/posts/index.html.erb"
    template_1 = ActionView::Template.find(file)
    template_2 = ActionView::Template.find(file)

    assert_same template_1, template_2
  end

  class TestController < ApplicationController
    def index
      @var = "yo"
    end
  end

  def test_find_template
    controller = TestController.new
    controller.index

    assert_equal({ "var" => "yo" }, controller.view_assigns)
  end

  def test_render
    request = Rack::MockRequest.new(Rails.application)

    response = request.get("/posts/show?id=1")

    puts response.body
    assert_match "<h1>Post A</h1>", response.body
  end
end
