# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'dashboard/posts/show', type: :view do
  before do
    assign(:dashboard_post, Dashboard::Post.create!(
                              visability: 2,
                              content: 'MyText',
                              post: nil
                            ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
