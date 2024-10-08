# frozen_string_literal: true

if model.success?
  if model.success.is_a?(Array) || model.success.respond_to?(:count)
    json.array! model.success do |success|
      json.partial! 'generic_transaction_results/model', model: success, partial:
    end
  else
    json.partial! 'generic_transaction_results/model', model: model.success, partial:
  end
end
