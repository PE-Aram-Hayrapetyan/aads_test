# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::Posts::IndexTransaction do
  let(:user) { create(:user) }
  let(:following) {create(:user_friends_relation, user:, other_user: create(:user))}
  let(:user_posts) do
    Array.new(30) { create(:post, user: [user, following.other_user].sample) }
  end

  describe "#call" do
    subject(:posts) { described_class.call(user_id: user.id) }

    context "when user exists" do
      before do
        following
      end

      it "returns success" do
        expect(posts).to be_success
      end

      it "returns user posts" do
        user_posts
        expect(posts.success).to match_array(user_posts)
      end
    end

  end
end
