# frozen_string_literal: true

module Dashboard
  module Posts
    class DestroyContract < ApplicationContract
      params do
        required(:id).filled(:string)
        required(:user_id).filled(:string)
      end

      rule(:id) do
        key.failure('is invalid') unless Post.exists?(id: value)
      end

      rule(:user_id) do
        key.failure('is invalid') unless User.exists?(id: value)
      end

      rule(:id, :user_id) do
        key.failure('is invalid') unless Post.exists?(id: values[:id], user_id: values[:user_id])
      end
    end
  end
end
