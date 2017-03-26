require "test_helper"

class ActiveViewTest < Minitest::Test
  def test_template_render
    template = ActionView::Template.new("<p>Yo</p>", "test_template")
    context = ActionView::Base.new

    assert_equal "<p>Yo</p>", template.render(context)
  end
end
