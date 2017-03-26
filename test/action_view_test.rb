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
end
