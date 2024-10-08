#!/usr/bin/env sh

rm -rf tmp/cache
docker compose run --rm test bundle install
docker compose run --rm test bundle exec rails db:reset
docker compose run --rm test bundle exec rails rswag:specs:swaggerize
docker compose run --rm test bundle exec vite build --clear --mode=test
docker compose run --rm test bundle exec rspec $1