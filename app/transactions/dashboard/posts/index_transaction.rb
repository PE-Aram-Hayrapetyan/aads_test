# frozen_string_literal: true

module Dashboard
  module Posts
    class IndexTransaction < ApplicationTransaction
      step :validate
      step :compile

      private

      def validate(input)
        contract = Posts::IndexContract.new
        result = contract.call(input)
        return Success(result.to_h) if result.success?

        Failure(result.errors.to_h)
      end

      def compile(input)
        posts = (Post.where(user_id: input[:user_id]) +
          UserFriendsRelation.where(user_id: input[:user_id]).map(&:other_user)
                             .map { |user| Post.where(user_id: user.id) } +
          Post.where(visibility: :everyone)).flatten.uniq.sort_by(&:created_at)
        Success(posts)
      rescue StandardError => e
        Failure({ error: [e.class.to_s, e.message] })
      end
    end
  end
end
