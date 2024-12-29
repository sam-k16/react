# Stage 1: Build the React app
FROM node:16-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
EXPOSE 3000 
ENTRYPOINT ["npm", "run", "start"]

