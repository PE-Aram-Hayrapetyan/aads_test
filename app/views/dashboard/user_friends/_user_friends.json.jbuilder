# frozen_string_literal: true

if model.instance_of?(Objects::Friends)
  json.extract! model, :followers, :following
else
  json.extract! model, :id, :user, :confirmed
end
