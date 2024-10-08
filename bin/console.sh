#!/usr/bin/env sh

docker compose run --rm web bundle exec rails db:prepare
docker compose run --rm web bundle exec rails console