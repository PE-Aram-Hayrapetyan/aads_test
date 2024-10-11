# frozen_string_literal: true

module Dashboard
  module Posts
    class ShowTransaction < ApplicationTransaction
      step :validate
      step :compile

      private

      def validate(input)
        contract = Posts::ShowContract.new
        result = contract.call(input)
        return Success(result.to_h) if result.success?

        Failure(result.errors.to_h)
      end

      def compile(input)
        post = Post.includes(:comments).find(input[:post_id])
        Success(Objects::Post.new(post))
      rescue StandardError => e
        Failure({ error: [e.class.to_s, e.message] })
      end
    end
  end
end
