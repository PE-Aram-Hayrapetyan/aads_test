# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    content { 'MyString' }
    visibility { 'MyString' }
    post { nil }
    user { nil }
  end
end
