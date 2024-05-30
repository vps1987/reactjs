#Stage 1
FROM node:22-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

#Stage 2
FROM nginx:latest
WORKDIR /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80/tcp
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]

