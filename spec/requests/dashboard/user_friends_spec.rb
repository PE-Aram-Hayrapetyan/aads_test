# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard::UserFriends', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let(:friends) do
    [create(:user_friends_relation, user:, other_user:, confirmed: true),
     create(:user_friends_relation, user: other_user, other_user: user)]
  end

  describe 'GET /dashboard/friends' do
    path '/users/dashboard/friends' do
      get 'List of friends' do
        tags 'User Friends'
        consumes 'application/json'
        produces 'application/json'

        response '200', 'list of friends' do
          before do
            sign_in user
            friends
          end

          schema type: :object,
                 properties: {
                   model: {
                     type: :object,
                     properties: {
                       followers: {
                         type: :array,
                         items: {
                           type: :object,
                           properties: {
                             id: { type: :string, format: :uuid },
                             user: {
                               type: :object,
                               properties: {
                                 id: { type: :string, format: :uuid },
                                 email: { type: :string, format: :email }
                               },
                               required: %w[id email]
                             },
                             confirmed: { type: :boolean }
                           },
                           required: %w[id user confirmed]
                         }
                       },
                       following: {
                         type: :array,
                         items: {
                           type: :object,
                           properties: {
                             id: { type: :string, format: :uuid },
                             user: {
                               type: :object,
                               properties: {
                                 id: { type: :string, format: :uuid },
                                 email: { type: :string, format: :email }
                               },
                               required: %w[id email]
                             },
                             confirmed: { type: :boolean }
                           },
                           required: %w[id user confirmed]
                         }
                       },
                       model: { type: :string }
                     },
                     required: %w[followers following model]
                   },
                   server_time: { type: :string, format: :'date-time' }
                 },
                 required: %w[model server_time]

          it 'All relations of user with other users', :openapi_strict_schema_validation do |example|
            submit_request(example.metadata)
            assert_response_matches_metadata(example.metadata)
          end
        end

        response '401', 'unauthorized' do
          let(:user_id) { user.id }
          run_test!
        end
      end
    end
  end

  describe 'POST /dashboard/friends' do
    let(:params) { { other_user_id: other_user.id } }

    path '/users/dashboard/friends' do
      post 'Create a friend relation' do
        tags 'User Friends'
        consumes 'application/json'
        produces 'application/json'

        parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            other_user_id: { type: :string, format: :uuid }
          },
          required: %w[friend_id]
        }

        response '200', 'friend relation created' do
          before do # rubocop:disable RSpec/ScatteredSetup
            sign_in user
          end

          schema type: :object,
                 properties: {
                   model: {
                     type: :object,
                     properties: {
                       id: { type: :string, format: :uuid },
                       user: {
                         type: :object,
                         properties: {
                           id: { type: :string, format: :uuid },
                           email: { type: :string, format: :email }
                         },
                         required: %w[id email]
                       },
                       confirmed: { type: :boolean },
                       model: { type: :string }
                     },
                     required: %w[id user confirmed model]
                   },
                   server_time: { type: :string, format: :'date-time' }
                 },
                 required: %w[model server_time]

          it 'creates a friend relation', :openapi_strict_schema_validation do |example|
            submit_request(example.metadata)
            assert_response_matches_metadata(example.metadata)
          end
        end

        response '422', 'unprocessable entity' do
          before do # rubocop:disable RSpec/ScatteredSetup
            sign_in user
          end

          schema type: :object,
                 properties: {
                   errors: {
                     type: :object,
                     properties: {
                       User: { type: :string, required: false, nullable: true },
                       Friend: { type: :string, required: false, nullable: true }
                     }
                   },
                   server_time: { type: :string, format: :'date-time' }
                 },
                 required: %w[server_time]

          context 'when befriending self' do
            let(:params) { { other_user_id: user.id } }

            it 'returns an error if user is trying to befriend themself', :openapi_strict_schema_validation do |example|
              submit_request(example.metadata)
              expect(response.parsed_body[:errors][:User]).to eq('are equal')
            end
          end

          context "when befriending a user that doesn't exist" do
            let(:params) { { other_user_id: SecureRandom.uuid } }

            it 'returns an error if user does not exist', :openapi_strict_schema_validation do |example|
              submit_request(example.metadata)
              expect(response.parsed_body[:errors][:Friend]).to eq('is invalid')
            end
          end

          context 'when already friends with the user' do
            let(:params) { { other_user_id: other_user.id } }

            it 'returns an error if user is already friends with the other user',
               :openapi_strict_schema_validation do |example|
              friends
              submit_request(example.metadata)
              expect(response.parsed_body[:errors][:User]).to eq('already friends')
            end
          end
        end

        response '401', 'unauthorized' do
          run_test!
        end
      end
    end
  end

  describe 'PUT /dashboard/friends/{id}' do
    let(:friend_relation) { create(:user_friends_relation, user:, other_user:) }
    let(:id) { friend_relation.id }

    path '/users/dashboard/friends/{id}' do
      put 'Update a friend relation' do
        tags 'User Friends'
        consumes 'application/json'
        produces 'application/json'

        parameter name: :id, in: :path, type: :string, format: :uuid

        response '200', 'friend relation updated' do
          before do # rubocop:disable RSpec/ScatteredSetup
            sign_in user
          end

          schema type: :object,
                 properties: {
                   model: {
                     type: :object,
                     properties: {
                       id: { type: :string, format: :uuid },
                       user: {
                         type: :object,
                         properties: {
                           id: { type: :string, format: :uuid },
                           email: { type: :string, format: :email }
                         },
                         required: %w[id email]
                       },
                       confirmed: { type: :boolean },
                       model: { type: :string }
                     },
                     required: %w[id user confirmed model]
                   },
                   server_time: { type: :string, format: :'date-time' }
                 },
                 required: %w[model server_time]

          it 'updates a friend relation', :openapi_strict_schema_validation do |example|
            submit_request(example.metadata)
            assert_response_matches_metadata(example.metadata)
          end
        end

        response '422', 'unprocessable entity' do
          before do # rubocop:disable RSpec/ScatteredSetup
            sign_in user
          end

          schema type: :object,
                 properties: {
                   errors: {
                     type: :object,
                     properties: {
                       Id: { type: :string, required: false, nullable: true }
                     }
                   },
                   server_time: { type: :string, format: :'date-time' }
                 },
                 required: %w[server_time]

          context 'when friend relation does not exist' do
            let(:id) { SecureRandom.uuid }

            it 'returns an error if friend relation does not exist', :openapi_strict_schema_validation do |example|
              submit_request(example.metadata)
              expect(response.parsed_body[:errors][:Id]).to eq('is invalid')
            end
          end

          context 'when friend relation is already confirmed' do
            let(:friend_relation) { create(:user_friends_relation, user:, other_user:, confirmed: true) }
            let(:id) { friend_relation.id }

            it 'returns an error if friend relation is already confirmed',
               :openapi_strict_schema_validation do |example|
              submit_request(example.metadata)
              expect(response.parsed_body[:errors][:Id]).to eq('already confirmed')
            end
          end
        end

        response '401', 'unauthorized' do
          run_test!
        end
      end
    end
  end

  describe 'DELETE /dashboard/friends/{id}' do
    let(:friend_relation) { create(:user_friends_relation, user:, other_user:) }
    let(:id) { friend_relation.id }

    path '/users/dashboard/friends/{id}' do
      delete 'Delete a friend relation' do
        tags 'User Friends'
        consumes 'application/json'
        produces 'application/json'

        parameter name: :id, in: :path, type: :string, format: :uuid

        response '200', 'friend relation deleted' do
          before do # rubocop:disable RSpec/ScatteredSetup
            sign_in user
          end

          schema type: :object,
                 properties: {
                   model: {
                     type: :object,
                     properties: {
                       id: { type: :string, format: :uuid },
                       user: {
                         type: :object,
                         properties: {
                           id: { type: :string, format: :uuid },
                           email: { type: :string, format: :email }
                         },
                         required: %w[id email]
                       },
                       confirmed: { type: :boolean },
                       model: { type: :string }
                     },
                     required: %w[id user confirmed model]
                   },
                   server_time: { type: :string, format: :'date-time' }
                 },
                 required: %w[model server_time]

          it 'deletes a friend relation', :openapi_strict_schema_validation do |example|
            submit_request(example.metadata)
            assert_response_matches_metadata(example.metadata)
          end
        end

        response '422', 'unprocessable entity' do
          before do # rubocop:disable RSpec/ScatteredSetup
            sign_in user
          end

          schema type: :object,
                 properties: {
                   errors: {
                     type: :object,
                     properties: {
                       Id: { type: :string, required: false, nullable: true }
                     }
                   },
                   server_time: { type: :string, format: :'date-time' }
                 },
                 required: %w[server_time]

          context 'when friend relation does not exist' do
            let(:id) { SecureRandom.uuid }

            it 'returns an error if friend relation does not exist', :openapi_strict_schema_validation do |example|
              submit_request(example.metadata)
              expect(response.parsed_body[:errors][:Id]).to eq('is invalid')
            end
          end
        end

        response '401', 'unauthorized' do
          run_test!
        end
      end
    end
  end
end
