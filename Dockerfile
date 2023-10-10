# Use an official Node.js runtime as a parent image
FROM node:latest as builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies using npm
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the application (if necessary)
RUN npm run build

# Use an official Nginx runtime as a parent image for serving the application
FROM nginx:latest

# Copy built files from the builder stage to the Nginx web root
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose the default Nginx port (80)
EXPOSE 80

# Start Nginx when the container is run
CMD ["nginx", "-g", "daemon off;"]
