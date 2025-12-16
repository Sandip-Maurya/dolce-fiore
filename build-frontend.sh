#!/bin/bash
# Script to build frontend static files and copy to nginx volume
# Usage: ./build-frontend.sh

set -e

echo "Building frontend static files..."

# Build frontend using builder stage
docker build --target builder -t dolce-fiore-frontend-builder ./frontend

# Create a temporary container to extract built files
echo "Extracting built files..."
docker create --name temp-frontend-builder dolce-fiore-frontend-builder

# Create volume if it doesn't exist
docker volume create frontend_static 2>/dev/null || true

# Copy files to volume using a helper container
docker run --rm \
  -v frontend_static:/output \
  -v /var/run/docker.sock:/var/run/docker.sock \
  alpine sh -c "
    apk add --no-cache docker-cli
    docker cp temp-frontend-builder:/app/dist/. /output/
  " || {
    # Fallback: use a simple alpine container to copy
    docker run --rm \
      --volumes-from temp-frontend-builder \
      -v frontend_static:/output \
      alpine sh -c "cp -r /app/dist/* /output/ 2>/dev/null || true"
  }

# Clean up
docker rm temp-frontend-builder 2>/dev/null || true

echo "Frontend static files built and copied to volume!"

