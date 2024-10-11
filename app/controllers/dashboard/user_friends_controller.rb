# frozen_string_literal: true

module Dashboard
  class UserFriendsController < Dashboard::AbstractUserController
    def index
      @collection = Dashboard::Users::Friends::IndexTransaction.call(user_id: current_user)
      render :show, status: status(@collection), formats: :json
    end

    def create
      @collection = Dashboard::Users::Friends::CreateTransaction.call(user_id: current_user,
                                                                      friend_id: params[:other_user_id])
      render :show, status: status(@collection), formats: :json
    end

    def destroy
      @collection = Dashboard::Users::Friends::DestroyTransaction.call(user_id: current_user,
                                                                       friend_id: params[:other_user_id])
      render :show, status: status(@collection), formats: :json
    end
  end
end
