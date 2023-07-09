#This Dockerfile sets up a node.js environment, installs the necessary application dependencies, copies the application code files into the container's filesystem, exposes port 8080, and defines a command to start the application by using multi-stage builds

# Build stage
FROM node:14 as build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM node:14
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/package*.json ./
RUN npm install --production
COPY --from=build /usr/src/app/dist ./dist
EXPOSE 8080
CMD [ "npm", "start" ]
