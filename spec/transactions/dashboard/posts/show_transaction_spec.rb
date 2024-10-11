# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::Posts::ShowTransaction do
  subject(:post) { described_class.call(input) }

  let(:user) { create(:user) }
  let(:user_post) do
    post1 = create(:post, user:)
    3.times do
      comment = post1.comments.create(user: create(:user), content: Faker::Lorem.sentence)
      6.times do
        comment.comments.create(user: create(:user), content: Faker::Lorem.sentence)
      end
    end
    post1
  end

  describe '#call' do
    context 'when post exists' do
      let(:input) { { user_id: user.id, post_id: user_post.id } }

      it 'returns success' do
        expect(post).to be_success
      end

      it 'returns post' do
        expect(post.success).to be_instance_of(Objects::Post)
      end

      it 'returns post with comments count' do
        expect(post.success.comments_count).to eq(user_post.comments.count)
      end
    end

    context 'when post does not exist' do
      let(:input) { { user_id: user.id, post_id: SecureRandom.uuid } }

      it 'returns failure' do
        expect(post).to be_failure
      end

      it 'returns error message' do
        expect(post.failure[:post_id]).to eq(['is invalid'])
      end
    end
  end
end
