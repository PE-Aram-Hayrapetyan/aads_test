# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard::Posts', type: :request do
  xdescribe 'GET /index' do
    it 'returns http success' do
      get '/dashboard/posts/index'
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe 'GET /show' do
    it 'returns http success' do
      get '/dashboard/posts/show'
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe 'GET /create' do
    it 'returns http success' do
      get '/dashboard/posts/create'
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe 'GET /update' do
    it 'returns http success' do
      get '/dashboard/posts/update'
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe 'GET /destroy' do
    it 'returns http success' do
      get '/dashboard/posts/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
