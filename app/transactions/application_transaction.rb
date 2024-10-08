# frozen_string_literal: true

require 'dry/transaction'
require 'dry/core'
require 'dry/transaction/operation'

# ApplicationTransaction is the base transaction that every other transaction inherits from
class ApplicationTransaction
  include Dry::Transaction

  def self.call(...)
    new.call(...)
  end
end
