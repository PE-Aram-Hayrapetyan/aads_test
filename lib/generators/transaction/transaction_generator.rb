# frozen_string_literal: true

require 'rails/generators'

# Class to generate transaction files and contract files
class TransactionGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_transaction_file
    template 'transaction.rb.template', File.join('app/transactions', class_path, "#{file_name}_transaction.rb")
  end

  def create_transaction_spec_file
    template 'transaction_spec.rb.template',
             File.join('spec/transactions', class_path, "#{file_name}_transaction_spec.rb")
  end

  def create_contract_file
    template 'contract.rb.template', File.join('app/contracts', class_path, "#{file_name}_contract.rb")
  end

  argument :name, type: :string
  argument :steps, type: :array, default: [], banner: 'step1 step2'
end
