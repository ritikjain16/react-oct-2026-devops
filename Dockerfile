FROM node:22-alpine AS build

WORKDIR /app
COPY package*.json ./

COPY . .
RUN npm run build

FROM nginx:alpine

RUN apk add --no-cache gettext

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/dist /usr/share/nginx/html
# Copy custom nginx config (optional)
COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]