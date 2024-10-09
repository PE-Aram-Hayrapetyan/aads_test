# frozen_string_literal: true

module Dashboard
  class Post < ApplicationRecord
    has_many :comments, dependent: :destroy, class_name: 'Dashboard::Post'
    belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
    belongs_to :parent, class_name: 'Dashboard::Post', optional: true

    enum :visibility, { visible: 0, friends_only: 1, invisible: 2 }
  end
end
