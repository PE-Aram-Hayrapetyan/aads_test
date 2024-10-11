# frozen_string_literal: true

module Dashboard
  module Posts
    class UpdateContract < CreateContract
      params do
        required(:id).filled(:string)
        optional(:content).maybe(:string)
        optional(:visibility).maybe(:string, included_in?: Post.visibilities.keys)
      end

      rule(:id) do
        key.failure('is invalid') unless Post.exists?(id: value)
      end
    end
  end
end
