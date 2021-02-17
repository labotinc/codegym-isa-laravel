define appbash
	docker-compose exec --user docker app bash -c
endef

up:
	docker-compose up -d
ps:
	docker-compose ps
down:
	docker-compose down
init:
	# echo DOCKER_UID=`id -u` > .env
	# docker-compose build --no-cache
	# docker-compose up -d
	$(appbash) 'cd laravelapp && pwd'
	$(appbash) 'cd laravelapp && ls -l'
# お手本
create-project:
	docker-compose up -d --build
	docker-compose exec app composer create-project --prefer-dist laravel/laravel .
	docker-compose exec app composer require predis/predis
install:
	docker-compose up -d --build
	docker-compose exec app composer install
	docker-compose exec app cp .env.example .env
	docker-compose exec app php artisan key:generate
	docker-compose exec app php artisan migrate:fresh --seed
