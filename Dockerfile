# build phase
FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install

COPY . .
RUN npm run build
# /app/build <-- needs to be migrated to nginx container

# run phase
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# no need to set CMD since container already starts up nginx
