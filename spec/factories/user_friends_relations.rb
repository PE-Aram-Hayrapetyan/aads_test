# frozen_string_literal: true

FactoryBot.define do
  factory :user_friends_relation do
    user { nil }
    other_user { nil }
    confirmed { false }
  end
end
