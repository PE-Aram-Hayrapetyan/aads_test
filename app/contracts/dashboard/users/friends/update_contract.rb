# frozen_string_literal: true

module Dashboard
  module Users
    module Friends
      class UpdateContract < DestroyContract
        params do
          # Inherited from DestroyContract
        end
        rule(:id) do
          key.failure('is invalid') unless UserFriendsRelation.exists?(id: value)
          key.failure('already confirmed') if UserFriendsRelation.exists?(id: value, confirmed: true)
        end
      end
    end
  end
end
