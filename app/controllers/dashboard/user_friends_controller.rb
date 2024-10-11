# frozen_string_literal: true

module Dashboard
  class UserFriendsController < Dashboard::AbstractUserController
    def index
      @collection = Dashboard::Users::Friends::IndexTransaction.call(user_id: current_user.id)
      render :show, status: status(@collection), formats: :json
    end

    def create
      @collection = Dashboard::Users::Friends::CreateTransaction.call(user_id: current_user.id,
                                                                      friend_id: params[:other_user_id])
      render :show, status: status(@collection), formats: :json
    end

    def update
      @collection = Dashboard::Users::Friends::UpdateTransaction.call(id: params[:id])
      render :show, status: status(@collection), formats: :json
    end

    def destroy
      @collection = Dashboard::Users::Friends::DestroyTransaction.call(id: params[:id])
      render :show, status: status(@collection), formats: :json
    end

    def search
      @collection = Dashboard::Users::Friends::SearchTransaction.call(user_id: current_user.id, query: params[:query])
      render :show, status: status(@collection), formats: :json
    end
  end
end
