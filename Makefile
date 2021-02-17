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
	echo DOCKER_UID=`id -u` > .env
	docker-compose build --no-cache
	docker-compose up -d
	$(appbash) 'composer install'
	$(appbash) 'chmod 777 -R storage bootstrap/cache'
	$(appbash) 'php artisan migrate:fresh --seed'
