FROM node:latest as build-stage
WORKDIR /usr/src/app
COPY ./recipes-web-app/package*.json ./
RUN npm install
COPY ./recipes-web-app .
RUN npm run build

FROM nginx as production-stage
RUN mkdir /app
COPY --from=build-stage /usr/src/app/dist /app
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]