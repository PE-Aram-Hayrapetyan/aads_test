# frozen_string_literal: true

module Dashboard
  module Users
    module Friends
      class DestroyContract < ApplicationContract
        params do
          required(:id).filled(:string)
        end

        rule(:id) do
          key.failure('is invalid') unless UserFriendsRelation.exists?(id: value)
        end
      end
    end
  end
end
