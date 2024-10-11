# frozen_string_literal: true

module Dashboard
  module Users
    module Friends
      class IndexContract < ApplicationContract
        params do
          required(:user_id).filled(:string)
        end

        rule(:user_id) do
          key.failure('is invalid') unless User.exists?(value)
        end
      end
    end
  end
end
