# ---------- FRONTEND BUILD ----------
FROM node:22-alpine as frontend-build

WORKDIR /app/frontend
COPY client/ .
RUN npm install
RUN npm run build


# ---------- BACKEND ----------
FROM node:22-alpine as backend

WORKDIR /app/backend
COPY server/package*.json ./
COPY server/ .
RUN npm install


# ---------- FINAL IMAGE ----------
FROM nginx:alpine

# install node for backend
RUN apk add --no-cache nodejs npm

# copy frontend build
COPY --from=frontend-build /app/frontend/dist /usr/share/nginx/html

# copy backend
COPY --from=backend /app/backend /app/backend

# copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# expose port
EXPOSE 80
ENV PORT=4000
# start both nginx + backend
CMD sh -c "node /app/backend/index.js & sleep 5 && nginx -g 'daemon off;'"