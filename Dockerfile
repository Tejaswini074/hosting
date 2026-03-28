# ---------- FRONTEND BUILD ----------
FROM node:22-alpine as client

WORKDIR /app
COPY client ./client

WORKDIR /app/client
RUN npm install
RUN npm run build


# ---------- BACKEND ----------
FROM node:22-alpine as server

WORKDIR /app/server
COPY server/package*.json ./
RUN npm install
COPY server/ .


# ---------- FINAL IMAGE ----------
# ---------- FRONTEND BUILD ----------
FROM node:22-alpine as client

WORKDIR /app
COPY client ./client

WORKDIR /app/client
RUN npm install
RUN npm run build


# ---------- BACKEND ----------
FROM node:22-alpine as server

WORKDIR /app/server
COPY server/package*.json ./
RUN npm install
COPY server/ .


# ---------- FINAL IMAGE ----------
FROM nginx:alpine

RUN apk add --no-cache nodejs npm

ENV PORT=4000

# ✅ frontend
COPY --from=client /app/client/dist /usr/share/nginx/html

# ✅ backend
COPY --from=server /app/server /app/server

# ✅ nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["sh", "-c", "node /app/server/index.js & nginx -g 'daemon off;'"]