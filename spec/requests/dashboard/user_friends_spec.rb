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
end
