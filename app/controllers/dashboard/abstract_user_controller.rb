# frozen_string_literal: true

module Dashboard
  class AbstractUserController < ApplicationController
    before_action :authenticate_user!
  end
end
