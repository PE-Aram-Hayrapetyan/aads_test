# frozen_string_literal: true

module Dashboard
  class AbstractUserController < ApplicationController
    before_action :authenticate_user!

    private

    def user_id
      { user_id: current_user.id }
    end
  end
end
