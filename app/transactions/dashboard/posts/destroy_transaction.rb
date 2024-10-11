# frozen_string_literal: true

module Dashboard
  module Posts
    class DestroyTransaction < ApplicationTransaction
      step :validate
      step :destroy

      private

      def validate(input)
        contract = Posts::DestroyContract.new
        result = contract.call(input)
        return Success(result.to_h) if result.success?

        Failure(result.errors.to_h)
      end

      def destroy(input)
        post = Post.find_by(id: input[:id], user_id: input[:user_id])
        object = Objects::Post.new(post)
        post.destroy!
        Success(object)
      rescue StandardError => e
        Failure({ error: [e.class.to_s, e.message] })
      end
    end
  end
end
