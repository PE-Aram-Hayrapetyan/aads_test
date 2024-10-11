# frozen_string_literal: true

module Dashboard
  module Posts
    class IndexTransaction < ApplicationTransaction
      step :validate
      step :compile

      private

      def comments_count
        <<~SQL.squish
          posts.*, (select count(*) from posts as comments where comments.post_id = posts.id) as comments_count
        SQL
      end

      def where_clause
        <<~SQL.squish
          posts.user_id = :user_id or user_friends_relations.user_id = :user_id or posts.visibility = :visibility
        SQL
      end

      def joins
        <<~SQL.squish
          left join user_friends_relations on user_friends_relations.other_user_id = posts.user_id
        SQL
      end

      def posts(input)
        Post
          .includes(:comments)
          .joins(joins)
          .where(where_clause, user_id: input[:user_id], visibility: Post.visibilities[:everyone])
          .distinct
          .order(:created_at)
      end

      def validate(input)
        contract = Posts::IndexContract.new
        result = contract.call(input)
        return Success(result.to_h) if result.success?

        Failure(result.errors.to_h)
      end

      def compile(input)
        Success(Objects::Post.from_array(posts(input)))
      rescue StandardError => e
        Failure({ error: [e.class.to_s, e.message] })
      end
    end
  end
end
