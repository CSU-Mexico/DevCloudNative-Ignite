#generar la app
FROM node:alpine as build-app
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . ./
RUN npm run start stencil build


#genera nginx
FROM nginx:1.16.0-alpine as server
COPY --from=build-app /app/www /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;"]
