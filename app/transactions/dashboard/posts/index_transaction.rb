# frozen_string_literal: true

module Dashboard
  module Posts
    class IndexTransaction < ApplicationTransaction
      step :validate
      step :compile

      private

      def comments_count
        'posts.*, (select count(*) from posts as comments where comments.post_id = posts.id) as comments_count'
      end

      def where_clause
        'posts.user_id = :user_id or user_friends_relations.user_id = :user_id or posts.visibility = :visibility'
      end

      def joins
        'left join user_friends_relations on user_friends_relations.other_user_id = posts.user_id'
      end

      def validate(input)
        contract = Posts::IndexContract.new
        result = contract.call(input)
        return Success(result.to_h) if result.success?

        Failure(result.errors.to_h)
      end

      def compile(input)
        posts = Post
                .includes(:comments)
                .joins(joins)
                .where(where_clause, user_id: input[:user_id], visibility: Post.visibilities[:everyone])
                .distinct
                .select(comments_count)
                .order(:created_at)

        Success(Objects::Post.from_array(posts))
      rescue StandardError => e
        Failure({ error: [e.class.to_s, e.message] })
      end
    end
  end
end
