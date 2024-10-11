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
        posts = Post.joins('left join user_friends_relations on user_friends_relations.other_user_id = posts.user_id')
                    .where('posts.user_id = :user_id or user_friends_relations.user_id = :user_id or posts.visibility = :visibility',
                           user_id: input[:user_id], visibility: Post.visibilities[:everyone])
                    .distinct
                    .order(:created_at)
        Success(posts)
      rescue StandardError => e
        Failure({ error: [e.class.to_s, e.message] })
      end
    end
  end
end
