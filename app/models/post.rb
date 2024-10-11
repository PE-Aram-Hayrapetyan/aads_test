# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :parent, class_name: 'Post', optional: true
  belongs_to :user
  has_many :comments, dependent: :destroy, class_name: 'Post'

  enum :visibility, { everyone: 1, friends_only: 2, nobody: 3 }
end
