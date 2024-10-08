# frozen_string_literal: true

FactoryBot.define do
  factory :dashboard_post, class: 'Dashboard::Post' do
    visability { 1 }
    content { 'MyText' }
    post { nil }
  end
end
