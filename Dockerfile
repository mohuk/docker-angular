FROM node:10.11.0-alpine as build-env

RUN mkdir -p /app
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . ./

EXPOSE 4200
ENTRYPOINT ["./node_modules/.bin/ng"]
CMD ["build"]

# Build runtime image
FROM nginx
COPY --from=build-env /app/dist/docker-angular /usr/share/nginx/html
