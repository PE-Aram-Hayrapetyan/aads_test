# frozen_string_literal: true

module Dashboard
  module Posts
    class CreateContract < ApplicationContract
      params do
        required(:content).filled(:string)
        required(:visibility).filled(:string, included_in?: Post.visibilities.keys)
        required(:user_id).filled(:string)
        optional(:post_id).maybe(:string)
      end

      rule(:content) do
        if value.present?
          key.failure('must be a string') unless value.is_a?(String)
          key.failure('must be less than 1000 characters') if value.length > 1000
          key.failure('must be at least 1 character') if value.empty?
        end
      end

      rule(:visibility) do
        if value.present?
          key.failure('must be a string') unless value.is_a?(String)
          key.failure("must be one of: #{Post.visibilities.keys.join(', ')}") unless Post.visibilities.key?(value)
        end
      end

      rule(:user_id) do
        key.failure('is invalid') unless User.exists?(id: value)
      end

      rule(:post_id) do
        key.failure('is invalid') if value.present? && !Post.exists?(id: value)
      end
    end
  end
end
