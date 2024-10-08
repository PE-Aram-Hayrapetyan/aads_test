# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'dashboard/posts/index', type: :view do
  before do
    assign(:dashboard_posts, [
             Dashboard::Post.create!(
               visability: 2,
               content: 'MyText',
               post: nil
             ),
             Dashboard::Post.create!(
               visability: 2,
               content: 'MyText',
               post: nil
             )
           ])
  end

  it 'renders a list of dashboard/posts' do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('MyText'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
