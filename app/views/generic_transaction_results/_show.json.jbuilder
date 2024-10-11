# frozen_string_literal: true

json.model do
  json.partial!('generic_transaction_results/transaction', model: transaction, partial:)
end
json.errors do
  json.partial! 'generic_transaction_results/failure', model: transaction
end
json.server_time Time.utc.now
