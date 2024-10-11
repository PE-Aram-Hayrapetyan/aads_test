# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::Users::Friends::SearchTransaction do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }

  describe '#call' do
    subject(:search) { described_class.call(query: friend.email[..3], user_id: user.id) }

    context 'when user and friend exist' do
      it 'returns success' do
        expect(search).to be_success
      end

      it 'returns a list of users' do
        expect(search.value!).to all(be_a(Objects::User))
      end
    end

    context 'when user does not exist' do
      it 'returns failure' do
        expect(described_class.call(query: friend.email, user_id: SecureRandom.uuid)).to be_failure
      end
    end
  end
end
