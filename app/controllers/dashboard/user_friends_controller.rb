# frozen_string_literal: true

module Dashboard
  class UserFriendsController < Dashboard::AbstractUserController
    def index
      @collection = Dashboard::Users::Friends::IndexTransaction.call(user_id: current_user)
      render :show, status: status(@post), formats: :json
    end

    def create; end

    def destroy; end
  end
end
