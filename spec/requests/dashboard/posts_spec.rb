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
                     items: {
                       type: :object,
                       properties: {
                         id: { type: :string, format: :uuid },
                         content: { type: :string },
                         user: {
                           type: :object,
                           properties: {
                             id: { type: :string, format: :uuid },
                             email: { type: :string, format: :email }
                           },
                           required: %w[id email]
                         },
                         visibility: { type: :string },
                         created_at: { type: :string, format: :'date-time' },
                         parent: { type: :string, nullable: true },
                         comments_count: { type: :integer },
                         comments: { type: :string, nullable: true },
                         model: { type: :string }
                       },
                       required: %w[id content user visibility created_at parent comments_count comments model]
                     }
                   },
                   server_time: { type: :string, format: :'date-time' }
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
