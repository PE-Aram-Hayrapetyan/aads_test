# frozen_string_literal: true

module Dashboard
  module Posts
    class CreateTransaction < ApplicationTransaction
      step :validate
      step :create

      private

      def validate(input)
        contract = Posts::CreateContract.new
        result = contract.call(input)
        return Success(result.to_h) if result.success?

        Failure(result.errors.to_h)
      end

      def create(input)
        post = Post.create!(input)

        Success(post)
      rescue StandardError => e
        Failure({ error: [e.class.to_s, e.message] })
      end
    end
  end
end
