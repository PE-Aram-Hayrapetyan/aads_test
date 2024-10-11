# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :parent, class_name: 'Post', optional: true
  belongs_to :user

  enum :visibility, { visible: 1, friends_only: 2, private: 3 }
end
