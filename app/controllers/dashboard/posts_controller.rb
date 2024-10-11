# frozen_string_literal: true

module Dashboard
  class PostsController < AbstractUserController
    def index
      @collection = Dashboard::Posts::Index.call(user_id: current_user.id)
      render :show, status: status(@collection), formats: :json
    end

    def show; end

    def create; end

    def update; end

    def destroy; end
  end
end
