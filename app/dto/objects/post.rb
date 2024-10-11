# frozen_string_literal: true

module Objects
  class Post
    attr_reader :id, :content, :user, :visibility, :created_at, :parent, :comments_count

    def initialize(post)
      @id = post.id
      @content = post.content
      @user = post.user
      @visibility = post.visibility
      @parent = post.parent
      @comments_count = post.comments_count
      @created_at = post.updated_at
    end

    def self.from_array(posts)
      posts.map { |post| new(post) }
    end
  end
end
