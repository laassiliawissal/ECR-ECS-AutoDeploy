# Use a base image that includes the Apache HTTP server
FROM httpd:latest

# Copy the custom HTML file to the Apache document root
COPY index.html /usr/local/apache2/htdocs/

# Expose port 80 (the same as the container port in the task definition)
EXPOSE 80

# The command to start the Apache HTTP server
CMD ["httpd-foreground"]
