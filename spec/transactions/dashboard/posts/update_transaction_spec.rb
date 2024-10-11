# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::Posts::UpdateTransaction do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }

  describe '#call' do
    context 'when valid input' do
      let(:input) { { user_id: user.id, id: post.id, content: 'content', visibility: 'everyone' } }

      it 'returns success' do
        expect(described_class.call(input)).to be_success
      end

      it 'updates post' do
        expect { described_class.call(input) }.to change { post.reload.content }.to('content')
      end
    end

    context 'when invalid input' do
      let(:input) { { user_id: user.id, id: post.id, content: nil, visibility: 'none' } }

      it 'returns failure' do
        expect(described_class.call(input)).to be_failure
      end

      it 'does not update post' do
        expect { described_class.call(input) }.not_to(change { post.reload.content })
      end
    end
  end
end
