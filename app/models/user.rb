# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy, class_name: 'Dashboard::Post'
  has_many :user_friends_relations, dependent: :destroy

  scope :followers, ->(user_id) { where(id: UserFriendRelation.where(other_user_id: user_id).pluck(:user_id)) }
end
