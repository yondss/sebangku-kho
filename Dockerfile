# Use Node.js base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy the rest of the app
COPY . .

# OpenSSL fix for Webpack (React dev server)
ENV NODE_OPTIONS=--openssl-legacy-provider

# Expose the port used by react-scripts (default: 3000)
EXPOSE 3000

# Run the React dev server
CMD ["npm", "start"]
