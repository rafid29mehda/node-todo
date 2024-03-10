# Use the official Node.js LTS image as the base image
FROM node:20-alpine

# Create a directory for the application
RUN mkdir -p /usr/src/app

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the entire project to the container
COPY . .

# Build the Angular app (you can customize this command as needed)
RUN npm run build

# Use a smaller, production-ready Nginx image as the final image
FROM nginx:alpine

# Copy the production-ready Angular app to the Nginx webserver's root directory
COPY --from=0 /usr/src/app/dist/your-angular-app /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
