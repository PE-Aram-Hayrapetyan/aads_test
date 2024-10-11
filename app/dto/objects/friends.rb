# frozen_string_literal: true

module Objects
  class Friends
    attr_reader :following, :followers

    def initialize(params)
      @params = params
      compile
    end

    private

    def compile
      @following = @params[:following].map do |following|
        Objects::Following.new(following.id)
      end

      @followers = @params[:followers].map do |follower|
        Objects::Follower.new(follower.id)
      end
    end
  end
end
