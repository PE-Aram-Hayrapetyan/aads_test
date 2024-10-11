# frozen_string_literal: true

module Objects
  class Post
    attr_reader :id, :content, :user, :visibility, :created_at, :parent, :comments_count, :comments, :model

    def initialize(post)
      @id = post.id
      @content = post.content
      @user = User.new(post.user.id)
      @visibility = post.visibility
      @parent = post.parent
      @comments_count = post.comments.count
      @created_at = post.updated_at
      @comments = recursive_build_comments(post)
      @model = self.class.name
    end

    def self.from_array(posts)
      posts.map { |post| new(post) }
    end

    private

    # TODO: can be optimized with a recursive query, but no time for that now
    def recursive_build_comments(post)
      post.comments.map do |comment|
        Post.new(comment)
      end
    end
  end
end
