spec=spec

prepare: bundle create load migrate

seed:
	docker-compose run --rm web bundle exec rake db:seed

bundle:
	docker-compose run --rm web bundle install

create:
	docker-compose run --rm web bundle exec rake db:create

load:
	docker-compose run --rm web bundle exec rake db:schema:load

migrate:
	docker-compose run --rm web bundle exec rake db:migrate

test:
	docker-compose run --rm web bundle exec rspec $(spec)
