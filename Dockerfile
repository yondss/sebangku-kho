# Stage 1: Build React app
FROM node:18-alpine as build

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps
RUN npm install node-sass

# Copy source code and build the app
COPY . .
# Add this line to fix Webpack crypto issue
ENV NODE_OPTIONS=--openssl-legacy-provider
RUN npm run build

# Stage 2: Serve app with Nginx
FROM nginx:alpine

# Copy the build output to Nginx's web directory
COPY --from=build /app/build /usr/share/nginx/html

# Remove the default Nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Add custom Nginx config
COPY nginx.conf /etc/nginx/conf.d

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
