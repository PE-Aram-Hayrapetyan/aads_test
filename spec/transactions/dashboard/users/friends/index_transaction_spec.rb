# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::Users::Friends::IndexTransaction do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let(:user_friends_relation) { create(:user_friends_relation, user:, other_user:, confirmed: true) }
  let(:other_user_friends_relation) do
    create(:user_friends_relation, user: other_user, other_user: user, confirmed: true)
  end

  let(:input) { { user_id: user.id } }

  describe '#call' do
    subject(:friends) { described_class.call(input) }

    context 'when user exists' do
      before do
        user_friends_relation
        other_user_friends_relation
      end

      it 'returns success' do
        expect(friends).to be_success
      end

      it 'returns followers and following' do
        expect(friends.success.followers.first.id).to eq(Objects::Follower.new(other_user_friends_relation.id).id)
        expect(friends.success.following.first.id).to eq(Objects::Following.new(user_friends_relation.id).id)
      end
    end

    context 'when user does not exist' do
      let(:input) { { user_id: SecureRandom.uuid } }

      it 'returns failure' do
        expect(friends).to be_failure
      end

      it 'returns error message' do
        expect(friends.failure[:user_id]).to eq(['is invalid'])
      end
    end
  end
end
