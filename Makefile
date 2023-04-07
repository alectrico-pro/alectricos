#ESto crea el esqueleto, usarlo solo una vez
new:
	docker build -t rails-toolbox -f rails.Dockerfile .
	docker run -it -v $(shell pwd):/opt/app rails-toolbox rails new --skip-bundle aelectrico

build:
	docker compose build 

tasks: 
	docker compose run server rake --tasks

cred:
	docker compose run server bin/rails EDITOR="vim --wait" credentials:edit 

.PHONY: server
server:
	docker compose up server

rspec:
	docker compose up rspec

test:
	docker compose up test

rake:
	docker compose up rake

prod:
	docker compose up prod

down:
	docker compose down

up:
	docker compose up

pc:
	docker exec -it  aelectrico bash -c "bundle exec rails assets:precompile RAILS_ENV=production"

assets: 
	docker compose up assets


