# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_friends_relations, dependent: :destroy
  has_many :followers, class_name: 'UserFriendsRelation', foreign_key: 'other_user_id', dependent: :destroy,
                       inverse_of: :other_user
  has_many :following, class_name: 'UserFriendsRelation', dependent: :destroy, inverse_of: :user
end
