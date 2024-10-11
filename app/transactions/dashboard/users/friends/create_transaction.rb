# frozen_string_literal: true

module Dashboard
  module Users
    module Friends
      class CreateTransaction < ApplicationTransaction
        step :verify

        step :create

        private

        def verify(input)
          contract = Dashboard::Users::Friends::CreateContract.new
          result = contract.call(input)
          return Success(result.to_h) if result.success?

          Failure(result.errors.to_h)
        end

        def create(input)
          relation = UserFriendsRelation.create!(user_id: input[:user_id], other_user_id: input[:friend_id])
          Success(Objects::Following.new(relation.id))
        rescue StandardError => e
          Failure({ error: [e.class.to_s, e.message] })
        end
      end
    end
  end
end
