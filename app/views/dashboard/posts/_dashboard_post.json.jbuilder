# frozen_string_literal: true

json.extract! dashboard_post, :id, :visability, :content, :post_id, :created_at, :updated_at
json.url dashboard_post_url(dashboard_post, format: :json)
