#!/bin/sh
set -e

# Select configuration based on NGINX_ENV environment variable
# Default to development if not set
NGINX_ENV=${NGINX_ENV:-development}

if [ "$NGINX_ENV" = "production" ]; then
    echo "Using production nginx configuration"
    cp /etc/nginx/nginx-prod.conf /etc/nginx/conf.d/default.conf
else
    echo "Using development nginx configuration"
    cp /etc/nginx/nginx-dev.conf /etc/nginx/conf.d/default.conf
fi

# Test nginx configuration
nginx -t

# Start nginx
exec nginx -g "daemon off;"

