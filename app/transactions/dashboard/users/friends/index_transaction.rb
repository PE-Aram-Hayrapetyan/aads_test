# frozen_string_literal: true

module Dashboard
  module Users
    module Friends
      class IndexTransaction < ApplicationTransaction
        step :verify

        step :compile

        private

        def verify(input)
          contract = Dashboard::Users::Friends::IndexContract.new
          result = contract.call(input)
          return Success(result.to_h) if result.success?

          Failure(result.errors.to_h)
        end

        def compile(input)
          user = User.find(input[:user_id])
          Success({
                    followers: user.followers,
                    following: user.following
                  })
        rescue StandardError => e
          Failure({ error: [e.class.to_s, e.message] })
        end
      end
    end
  end
end
