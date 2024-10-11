# frozen_string_literal: true

module Dashboard
  module Users
    module Friends
      class SearchContract < ApplicationContract
        params do
          required(:query).filled(:string)
          required(:user_id).filled(:string)
        end

        rule(:user_id) do
          key.failure('is invalid') unless User.exists?(id: value)
        end
      end
    end
  end
end
