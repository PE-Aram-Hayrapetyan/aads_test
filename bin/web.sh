#!/usr/bin/env sh

docker compose build
docker compose run --rm web bundle exec rails db:prepare
bundle exec foreman start -f Procfile.dev
