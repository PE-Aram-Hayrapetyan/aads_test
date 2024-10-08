# frozen_string_literal: true

# ApplicationContract is the base contract that every other contract inherits from
class ApplicationContract < Dry::Validation::Contract
  def filled?(value)
    value.present?
  end
end
