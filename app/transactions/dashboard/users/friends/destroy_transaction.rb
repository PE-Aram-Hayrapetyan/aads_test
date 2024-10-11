# frozen_string_literal: true

module Dashboard
  module Users
    module Friends
      class DestroyTransaction < ApplicationTransaction
        step :verify

        step :destroy

        private

        def verify(input)
          contract = Dashboard::Users::Friends::DestroyContract.new
          result = contract.call(input)
          return Success(result.to_h) if result.success?

          Failure(result.errors.to_h)
        end

        def destroy(input)
          relation = UserFriendsRelation.find(input[:id])
          return Failure({ error: ['friend not found'] }) if relation.blank?

          follower = Objects::Following.new(relation.id)
          relation.destroy!
          Success(follower)
        rescue StandardError => e
          Failure({ error: [e.class.to_s, e.message] })
        end
      end
    end
  end
end
