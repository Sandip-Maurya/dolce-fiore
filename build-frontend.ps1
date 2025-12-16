# PowerShell script to build frontend static files and copy to nginx volume
# Usage: .\build-frontend.ps1

Write-Host "Building frontend static files..." -ForegroundColor Green

# Build frontend using builder stage
docker build --target builder -t dolce-fiore-frontend-builder ./frontend

# Create a temporary container to extract built files
Write-Host "Extracting built files..." -ForegroundColor Green
docker create --name temp-frontend-builder dolce-fiore-frontend-builder

# Create volume if it doesn't exist
docker volume create frontend_static 2>$null

# Copy files to volume using a helper container
Write-Host "Copying files to volume..." -ForegroundColor Green
docker run --rm `
  --volumes-from temp-frontend-builder `
  -v frontend_static:/output `
  alpine sh -c "cp -r /app/dist/* /output/ 2>/dev/null || true"

# Clean up
docker rm temp-frontend-builder 2>$null

Write-Host "Frontend static files built and copied to volume!" -ForegroundColor Green

