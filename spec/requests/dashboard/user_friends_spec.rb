# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard::UserFriends', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/dashboard/user_friends/index'
      expect(response).to be_success(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/dashboard/user_friends/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/dashboard/user_friends/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
