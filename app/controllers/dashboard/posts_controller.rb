# frozen_string_literal: true

module Dashboard
  class PostsController < AbstractUserController
    helper AbstractUserHelper
    before_action :set_dashboard_post, only: %i[show edit update destroy]

    def index
      with_format(user_id, Dashboard::Post::IndexTransaction) do |result|
        result.success = proc {}
        result.failure = proc {}
      end
    end

    # GET /dashboard/posts/1 or /dashboard/posts/1.json
    def show; end

    # GET /dashboard/posts/new
    def new
      @dashboard_post = Dashboard::Post.new
    end

    # GET /dashboard/posts/1/edit
    def edit; end

    # POST /dashboard/posts or /dashboard/posts.json
    def create
      @dashboard_post = Dashboard::Post.new(dashboard_post_params)

      respond_to do |format|
        if @dashboard_post.save
          format.html { redirect_to @dashboard_post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @dashboard_post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @dashboard_post.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /dashboard/posts/1 or /dashboard/posts/1.json
    def update
      respond_to do |format|
        if @dashboard_post.update(dashboard_post_params)
          format.html { redirect_to @dashboard_post, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @dashboard_post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @dashboard_post.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /dashboard/posts/1 or /dashboard/posts/1.json
    def destroy
      @dashboard_post.destroy!

      respond_to do |format|
        format.html { redirect_to dashboard_posts_path, status: :see_other, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard_post
      @dashboard_post = Dashboard::Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dashboard_post_params
      params.require(:dashboard_post).permit(:visibility, :content, :post_id)
    end
  end
end
