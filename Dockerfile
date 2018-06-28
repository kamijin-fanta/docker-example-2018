FROM node:9.11 AS build

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn

COPY . ./
RUN CI=true yarn test --ci
RUN yarn build


FROM nginx:1.15 AS web

COPY --from=build /app/build /usr/share/nginx/html
