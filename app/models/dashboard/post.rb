# frozen_string_literal: true

module Dashboard
  class Post < ApplicationRecord
    has_many :comments, dependent: :destroy, class_name: 'Dashboard::Post'
    belongs_to :creator, class_name: 'User'
    belongs_to :parent, class_name: 'Dashboard::Post', optional: true

    enum :visibility, { public: 0, friends_only: 1, private: 2 }
  end
end
