# frozen_string_literal: true

module Dashboard
  module Users
    module Friends
      class SearchTransaction < ApplicationTransaction
        step :validate

        step :search

        private

        def validate(input)
          contract = Dashboard::Users::Friends::SearchContract.new
          result = contract.call(input)
          return Success(result.to_h) if result.success?

          Failure(result.errors.to_h)
        end

        def search(input)
          users = User.where('to_tsvector(email) @@ to_tsquery(:query)', query: "#{input[:query]}:*")

          Success(Objects::User.from_array(users))
        rescue StandardError => e
          Failure({ error: [e.class.to_s, e.message] })
        end
      end
    end
  end
end
