# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::Posts::IndexTransaction do
  subject(:posts) { described_class.call(input) }

  let(:user) { create(:user) }
  let(:following) { create(:user_friends_relation, user:, other_user: create(:user)) }
  let(:user_posts) do
    Array.new(30) { create(:post, user: [user, following.other_user].sample) } +
      Array.new(10) { create(:post, user: create(:user), visibility: :everyone) }
  end

  describe '#call' do
    context 'when user exists' do
      let(:input) { { user_id: user.id } }

      before do
        following
      end

      it 'returns success' do
        expect(posts).to be_success
      end

      it 'returns user posts' do
        user_posts
        expect(posts.success.count).to eq(user_posts.count)
      end

      it 'returns user posts ordered by created_at' do
        user_posts
        expect(posts.success.first.created_at).to be < posts.success.last.created_at
      end

      it 'returns user posts with comments count' do
        user_posts
        post = posts.success.first
        expect(post.comments_count).to eq(Post.find(post.id).comments.count)
      end
    end

    context 'when user does not exist' do
      let(:input) { { user_id: SecureRandom.uuid } }

      it 'returns failure' do
        expect(posts).to be_failure
      end

      it 'returns error message' do
        expect(posts.failure[:user_id]).to eq(['is invalid'])
      end
    end
  end
end
