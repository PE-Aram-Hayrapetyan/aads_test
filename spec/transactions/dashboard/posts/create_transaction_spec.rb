# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::Posts::CreateTransaction do
  let(:user) { create(:user) }

  describe '#call' do
    context 'when valid input' do
      let(:input) { { user_id: user.id, content: 'content', visibility: 'everyone' } }

      it 'returns success' do
        expect(described_class.call(input)).to be_success
      end

      it 'creates post' do
        expect { described_class.call(input) }.to change(Post, :count).by(1)
      end
    end

    context 'when invalid input' do
      let(:input) { { user_id: user.id, content: nil, visibility: 'none' } }

      it 'returns failure' do
        expect(described_class.call(input)).to be_failure
      end

      it 'returns error message' do
        expect(described_class.call(input).failure[:content]).to eq(['must be filled'])
      end

      it 'does not create post' do
        expect { described_class.call(input) }.not_to change(Post, :count)
      end
    end
  end
end
