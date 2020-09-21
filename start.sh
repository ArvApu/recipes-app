#!/usr/bin/env sh

echo "Building images..."

docker-compose build

echo "\n-----------------------------\n BUILD STAGE COMPLETED \n-----------------------------\n"

echo "Starting up services..."

docker-compose up -d 

echo '####                (25%)\r'
sleep 5
echo '########            (50%)\r'
sleep 5
echo '############        (75%)\r'           
sleep 5
echo '################    (100%)\r'
echo '\n'


# API commands
docker exec -it api-server composer install --optimize-autoloader --no-interaction;
docker exec -it api-server php artisan migrate;

# OAuth commands 
docker exec -it oauth-server composer install --optimize-autoloader --no-interaction;

docker exec -it oauth-server php artisan cache:clear;
docker exec -it oauth-server php artisan route:cache;
docker exec -it oauth-server php artisan config:cache;
docker exec -it oauth-server php artisan view:clear;

docker exec -it oauth-server php artisan migrate;
