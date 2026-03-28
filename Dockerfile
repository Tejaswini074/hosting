# ---------- FRONTEND BUILD ----------
FROM node:22-alpine as client

WORKDIR /app/frontend
COPY client/ .
RUN npm install
RUN npm run build


# ---------- BACKEND ----------
FROM node:22-alpine as server

WORKDIR /app/backend
COPY server/package*.json ./
RUN npm install
COPY server/ .


# ---------- FINAL IMAGE ----------
FROM nginx:alpine

# install node for backend
RUN apk add --no-cache nodejs npm

ENV PORT=4000

# copy frontend build
COPY --from=client /app/frontend/dist /usr/share/nginx/html

# copy backend
COPY --from=server /app/backend /app/backend

# copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# start backend + nginx
CMD ["sh", "-c", "node /app/backend/index.js & sleep 5 && nginx -g 'daemon off;'"]