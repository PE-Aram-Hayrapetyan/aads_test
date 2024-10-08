# frozen_string_literal: true

class UserFriendsRelation < ApplicationRecord
  belongs_to :user
  belongs_to :other_user
end
