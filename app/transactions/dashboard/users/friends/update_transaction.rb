# frozen_string_literal: true

module Dashboard
  module Users
    module Friends
      class UpdateTransaction < ApplicationTransaction
        step :validate

        step :update

        private

        def validate(input)
          contract = Dashboard::Users::Friends::UpdateContract.new
          result = contract.call(input)
          return Success(result.to_h) if result.success?

          Failure(result.errors.to_h)
        end

        def update(input)
          relation = UserFriendsRelation.find(input[:id])
          relation.update!(confirmed: true)
          Success(Objects::Following.new(relation.id))
        rescue StandardError => e
          Failure({ error: [e.class.to_s, e.message] })
        end
      end
    end
  end
end
