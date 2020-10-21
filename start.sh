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
docker exec -it oauth-server npm install;
docker exec -it oauth-server npm run dev;
docker exec -it api-server php artisan app:prepare;

# OAuth commands 
docker exec -it oauth-server composer install --optimize-autoloader --no-interaction;
docker exec -it api-server php artisan app:prepare;
