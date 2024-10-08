# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'dashboard/posts/edit', type: :view do
  let(:dashboard_post) do
    Dashboard::Post.create!(
      visability: 1,
      content: 'MyText',
      post: nil
    )
  end

  before do
    assign(:dashboard_post, dashboard_post)
  end

  it 'renders the edit dashboard_post form' do
    render

    assert_select 'form[action=?][method=?]', dashboard_post_path(dashboard_post), 'post' do
      assert_select 'input[name=?]', 'dashboard_post[visability]'

      assert_select 'textarea[name=?]', 'dashboard_post[content]'

      assert_select 'input[name=?]', 'dashboard_post[post_id]'
    end
  end
end
