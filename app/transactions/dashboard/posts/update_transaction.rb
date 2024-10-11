# frozen_string_literal: true

module Dashboard
  module Posts
    class UpdateTransaction < ApplicationTransaction
      step :validate
      step :update

      private

      def validate(input)
        contract = Posts::UpdateContract.new
        result = contract.call(input)
        return Success(result.to_h) if result.success?

        Failure(result.errors.to_h)
      end

      def update(input)
        post = Post.find_by(id: input[:id], user_id: input[:user_id])

        post.update!(input.except(:id, :user_id))
        Success(Objects::Post.new(post.reload))
      rescue StandardError => e
        Failure({ error: [e.class.to_s, e.message] })
      end
    end
  end
end
