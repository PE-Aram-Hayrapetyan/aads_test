# frozen_string_literal: true

module Dashboard
  module Posts
    class IndexTransaction < ApplicationTransaction
      step :validate

      step :compile

      private

      def validate(input); end

      def compile(input); end
    end
  end
end
