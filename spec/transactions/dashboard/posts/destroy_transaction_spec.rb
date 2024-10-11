# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::Posts::DestroyTransaction do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }

  describe '#call' do
    context 'when valid input' do
      let(:input) { { user_id: user.id, id: post.id } }

      it 'returns success' do
        expect(described_class.call(input)).to be_success
      end

      it 'destroys post' do
        post
        expect { described_class.call(input) }.to change(Post, :count).by(-1)
      end
    end

    context 'when invalid input' do
      let(:input) { { user_id: user.id, id: nil } }

      it 'returns failure' do
        expect(described_class.call(input)).to be_failure
      end

      it 'does not destroy post' do
        expect { described_class.call(input) }.not_to(change(Post, :count))
      end
    end
  end
end
