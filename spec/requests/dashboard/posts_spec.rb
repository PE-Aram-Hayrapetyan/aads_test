# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard::Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/dashboard/posts/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/dashboard/posts/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/dashboard/posts/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      get '/dashboard/posts/update'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/dashboard/posts/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
