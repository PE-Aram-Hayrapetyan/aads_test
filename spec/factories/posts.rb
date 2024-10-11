# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    content { Faker::Lorem.sentence }
    visibility { Post.visibilities.keys.sample }
    user { association(:user) }
  end
end
