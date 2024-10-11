# frozen_string_literal: true

module Dashboard
  class PostsController < AbstractUserController
    def index
      @collection = Dashboard::Posts::Index.call(user_id: current_user.id)
      render :show, status: status(@collection), formats: :json
    end

    def show
      @collection = Dashboard::Posts::ShowTransaction.call(user_id: current_user.id, post_id: params[:id])
      render :show, status: status(@collection), formats: :json
    end

    def create
      @collection = Dashboard::Posts::CreateTransaction.call(post_params.merge(user_id: current_user.id).to_h)
      render :show, status: status(@collection), formats: :json
    end

    def update
      @collection = Dashboard::Posts::UpdateTransaction.call(post_params.merge(user_id: current_user.id).to_h)
      render :show, status: status(@collection), formats: :json
    end

    def destroy
      @collection = Dashboard::Posts::DestroyTransaction.call(user_id: current_user.id, post_id: params[:id])
      render :show, status: status(@collection), formats: :json
    end

    private

    def post_params
      params.require(:post).permit(:content, :visibility, :post_id)
    end
  end
end
