# Multi-stage build for nginx
# Stage 1: Copy frontend static files (if available in build context)
FROM alpine AS frontend-static
# In production, frontend static files should be built separately
# and copied to ../frontend/dist, or mounted via volume at runtime
# This stage is a placeholder - actual files come from volume in docker-compose
RUN mkdir -p /static
# If frontend dist exists in build context, copy it
# Note: In production, use volume mount instead (see docker-compose.yml)

# Stage 2: Nginx with configurations
FROM nginx:alpine

# Copy main nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy environment-specific configurations
COPY nginx-dev.conf /etc/nginx/nginx-dev.conf
COPY nginx-prod.conf /etc/nginx/nginx-prod.conf

# Copy entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Create directory for server configs
RUN mkdir -p /etc/nginx/conf.d

# In production, static files are mounted via volume
# This ensures the directory exists
RUN mkdir -p /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Use custom entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]

