# frozen_string_literal: true

module Dashboard
  module AbstractUserHelper
    def with_format(params, transaction)
      respond_to do |format|
        result = transaction.call(params)
        format.json { render :show, params: { result: }, status: status(result), formats: :json }
        format.html do
          yield request_result if block_given?
          method = result.success? ? request_result.success : request_result.failure
          method.call
        end
      end
    end

    private

    def request_result
      @request_result ||= Utils::RequestStatus.new
    end
  end
end
