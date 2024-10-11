# frozen_string_literal: true

if model.instance_of?(Objects::Friends)
  json.extract! model, :followers, :following
elsif model.instance_of?(Objects::User)
  json.extract! model, :id, :email
else
  json.extract! model, :id, :user, :confirmed
end
