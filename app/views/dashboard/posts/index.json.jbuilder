# frozen_string_literal: true

json.array! @dashboard_posts, partial: 'dashboard/posts/dashboard_post', as: :dashboard_post
