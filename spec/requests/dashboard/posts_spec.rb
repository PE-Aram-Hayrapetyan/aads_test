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
                 required: %w[server_time]

          let(:user) { create(:user) }
          let(:user_posts) do
            post1 = create(:post, user:)
            3.times do
              comment = post1.comments.create(user: create(:user), content: Faker::Lorem.sentence,
                                              visibility: :everyone)
              6.times do
                comment.comments.create(user: create(:user), content: Faker::Lorem.sentence, visibility: :everyone)
              end
            end
            post1
          end

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

  describe 'GET /create' do
    path '/users/dashboard/posts' do
      post 'Create a post' do
        tags 'Dashboard::Posts'
        consumes 'application/json'
        produces 'application/json'

        parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            post: {
              type: :object,
              properties: {
                content: { type: :string },
                visibility: { type: :string, enum: Post.visibilities.keys }
              }
            }
          }
        }

        response '200', 'post created' do
          before { sign_in(user) } # rubocop:disable RSpec/ScatteredSetup

          schema type: :object,
                 properties: {
                   model: { type: :object, '$ref': '#/components/schemas/post' },
                   server_time: { type: :string }
                 },
                 required: %w[model server_time]

          let(:user) { create(:user) }
          let(:params) { attributes_for(:post) }

          it 'creates a post', :openapi_strict_schema_validation do |example| # rubocop:disable RSpec/RepeatedExample
            submit_request(example.metadata)
            assert_response_matches_metadata(example.metadata)
          end
        end

        response '401', 'user not found' do
          let(:params) { attributes_for(:post) }
          run_test!
        end

        response '422', 'invalid request' do
          before { sign_in(user) } # rubocop:disable RSpec/ScatteredSetup

          let(:user) { create(:user) }
          let(:params) { { post: { content: nil, visibility: 'none' } } }

          schema type: :object,
                 properties: {
                   errors: {
                     type: :object,
                     properties: {
                       Content: { type: :string },
                       Visibility: { type: :string }
                     }
                   },
                   server_time: { type: :string }
                 }

          it 'returns error message', :openapi_strict_schema_validation do |example| # rubocop:disable RSpec/RepeatedExample
            submit_request(example.metadata)
            assert_response_matches_metadata(example.metadata)
          end
        end
      end
    end
  end

  describe 'GET /update' do
    path '/users/dashboard/posts/{id}' do
      put 'Update a post' do
        tags 'Dashboard::Posts'
        consumes 'application/json'
        produces 'application/json'

        parameter name: :id, in: :path, type: :string, required: true
        parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            post: {
              type: :object,
              properties: {
                content: { type: :string },
                visibility: { type: :string, enum: Post.visibilities.keys }
              }
            }
          }
        }

        response '200', 'post updated' do
          before { sign_in(user) } # rubocop:disable RSpec/ScatteredSetup

          schema type: :object,
                 properties: {
                   model: { type: :object, '$ref': '#/components/schemas/post' },
                   server_time: { type: :string }
                 },
                 required: %w[model server_time]

          let(:user) { create(:user) }
          let(:post) { create(:post, user:) }
          let(:id) { post.id }
          let(:params) { { post: { content: 'content', visibility: 'everyone' } } }

          it 'updates a post', :openapi_strict_schema_validation do |example|
            submit_request(example.metadata)
            assert_response_matches_metadata(example.metadata)
          end
        end

        response '401', 'user not found' do
          let(:id) { SecureRandom.uuid }
          let(:params) { attributes_for(:post) }
          run_test!
        end

        response '422', 'invalid request' do
          before { sign_in(user) } # rubocop:disable RSpec/ScatteredSetup

          let(:user) { create(:user) }
          let(:post) { create(:post, user:) }
          let(:id) { post.id }
          let(:params) { { post: { content: nil, visibility: 'none' } } }

          schema type: :object,
                 properties: {
                   errors: {
                     type: :object,
                     properties: {
                       Content: { type: :string },
                       Visibility: { type: :string }
                     }
                   },
                   server_time: { type: :string }
                 }

          run_test!
        end
      end
    end
  end

  xdescribe 'GET /destroy' do
    it 'returns http success' do
      get '/dashboard/posts/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
