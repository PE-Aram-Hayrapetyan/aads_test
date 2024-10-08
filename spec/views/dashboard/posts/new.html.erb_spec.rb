# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'dashboard/posts/new', type: :view do
  before do
    assign(:dashboard_post, Dashboard::Post.new(
                              visability: 1,
                              content: 'MyText',
                              post: nil
                            ))
  end

  it 'renders new dashboard_post form' do
    render

    assert_select 'form[action=?][method=?]', dashboard_posts_path, 'post' do
      assert_select 'input[name=?]', 'dashboard_post[visability]'

      assert_select 'textarea[name=?]', 'dashboard_post[content]'

      assert_select 'input[name=?]', 'dashboard_post[post_id]'
    end
  end
end
