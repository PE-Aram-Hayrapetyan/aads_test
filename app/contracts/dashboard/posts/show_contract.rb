# frozen_string_literal: true

module Dashboard
  module Posts
    class ShowContract < IndexContract
      params do
        required(:post_id).filled(:string)
      end

      rule(:post_id) do
        key.failure('is invalid') unless Post.exists?(value)
      end
    end
  end
end
