# frozen_string_literal: true

module Dashboard
  module Users
    module Friends
      class DestroyContract < ApplicationContract
        params do
          required(:user_id).filled(:string)
          required(:friend_id).filled(:string)
        end

        rule(:user_id) do
          key.failure('is_invalid') unless User.exists?(id: value)
        end

        rule(:friend_id) do
          key.failure('is_invalid') unless User.exists?(id: value)
        end

        rule(:user_id, :friend_id) do
          key.failure('are_equal') if values[:user_id] == values[:friend_id]

          key.failure('not_friends') unless UserFriendsRelation.exists?(user_id: values[:user_id],
                                                                        other_user_id: values[:friend_id])
        end
      end
    end
  end
end
