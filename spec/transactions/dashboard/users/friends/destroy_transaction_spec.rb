# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::Users::Friends::DestroyTransaction do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let(:friend_relation) { create(:user_friends_relation, user:, other_user: friend) }

  describe '#call' do
    subject(:destroy_friend) { described_class.call(id: friend_relation.id) }

    context 'when user and friend exist' do
      it 'returns success' do
        expect(destroy_friend).to be_success
      end

      it 'destroys a friend relation' do
        friend_relation
        expect { destroy_friend }.to change(UserFriendsRelation, :count).by(-1)
      end
    end

    context 'when user does not exist' do
      it 'returns failure' do
        expect(described_class.call(id: SecureRandom.uuid)).to be_failure
      end
    end

    context 'when friend does not exist' do
      it 'returns failure' do
        expect(described_class.call(user_id: user.id, friend_id: SecureRandom.uuid)).to be_failure
      end
    end

    context 'when user and friend are the same' do
      it 'returns failure' do
        expect(described_class.call(user_id: user.id, friend_id: user.id)).to be_failure
      end
    end

    context 'when user and friend are not friends' do
      it 'returns failure' do
        expect(described_class.call(user_id: user.id, friend_id: friend.id)).to be_failure
      end
    end
  end
end
