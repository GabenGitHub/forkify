# build environment
FROM node:16-alpine as build
COPY package.json ./
COPY webpack.config.js ./
WORKDIR /src

RUN npm install
COPY src/ ./
RUN npm run build

# production environment
FROM nginx:stable-alpine
COPY --from=build /dist /usr/share/nginx/html
COPY src/css/ /usr/share/nginx/html/css/
COPY src/img/ /usr/share/nginx/html/img/
