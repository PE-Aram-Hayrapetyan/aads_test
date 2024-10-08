#!/usr/bin/env sh

docker compose build
docker compose run --rm web bundle exec rails db:prepare
docker compose run --rm -p 3000:3000 --tty web bundle exec rails s -b 0.0.0.0 -p 3000
