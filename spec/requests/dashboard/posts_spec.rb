# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard::Posts', type: :request do
  describe 'GET /index' do
    path '/users/dashboard/posts' do
      get 'Get all posts' do
        tags 'Dashboard::Posts'
        produces 'application/json'

        response '200', 'posts found' do
          before { sign_in(user) }

          schema type: :object,
                 properties: {
                   model: {
                     type: :array,
                     items: { type: :object, '$ref': '#/components/schemas/post' }
                   },
                   server_time: { type: :string }
                 },
                 required: %w[model server_time]

          let(:user) { create(:user) }
          let(:following) { create(:user_friends_relation, user:, other_user: create(:user)) }
          let(:user_posts) do
            Array.new(3) { create(:post, user: [user, following.other_user].sample) } +
              Array.new(2) { create(:post, user: create(:user), visibility: :everyone) }
          end

          let(:user_id) { user.id }

          it 'returns all posts', :openapi_strict_schema_validation do |example|
            user_posts
            submit_request(example.metadata)
            assert_response_matches_metadata(example.metadata)
          end
        end

        response '401', 'user not found' do
          run_test!
        end
      end
    end
  end

  describe 'GET /show' do
    path '/users/dashboard/posts/{id}' do
      get 'Get a single post' do
        tags 'Dashboard::Posts'
        produces 'application/json'

        parameter name: :id, in: :path, type: :string, required: true

        response '200', 'post found' do
          before { sign_in(user) }

          schema type: :object,
                 properties: {
                   model: { type: :object, '$ref': '#/components/schemas/post' },
                   server_time: { type: :string }
                 },
                 required: %w[model server_time]

          let(:user) { create(:user) }
          let(:user_posts) { create(:post, user:) }

          let(:id) { user_posts.id }

          it 'returns a single post', :openapi_strict_schema_validation do |example|
            submit_request(example.metadata)
            assert_response_matches_metadata(example.metadata)
          end
        end

        response '401', 'user not found' do
          let(:id) { SecureRandom.uuid }
          run_test!
        end
      end
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
