# Use the official Nginx image as the base image
FROM nginx:latest

# Expose port 80 to the outside world
EXPOSE 80

# Copy any custom configuration files or content to the container, if needed
# Example: COPY nginx.conf /etc/nginx/nginx.conf
# THIS line is for push

# Start the Nginx web server when the container starts
CMD ["nginx", "-g", "daemon off;"]
