# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::Users::Friends::UpdateTransaction do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let(:friend_relation) { create(:user_friends_relation, user:, other_user: friend) }

  describe '#call' do
    subject(:update_friend) { described_class.call(id: friend_relation.id) }

    context 'when friend relation exists' do
      it 'returns success' do
        expect(update_friend).to be_success
      end

      it 'updates a friend relation' do
        friend_relation
        expect { update_friend }.to change { friend_relation.reload.confirmed }.from(false).to(true)
      end
    end

    context 'when friend relation does not exist' do
      it 'returns failure' do
        expect(described_class.call(id: SecureRandom.uuid)).to be_failure
      end
    end
  end
end
