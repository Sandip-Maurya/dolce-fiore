# Backend Dockerfile for Dolce Fiore Django Application
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    libpq-dev \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Install uv package manager
RUN pip install --no-cache-dir uv

# Copy dependency files
COPY pyproject.toml uv.lock ./

# Install Python dependencies using uv (without installing the project itself)
# We only need dependencies, not the project as a package
RUN uv sync --frozen --no-install-project

# Copy application code
COPY . .

# Create directories for static files and media
RUN mkdir -p /app/staticfiles /app/media

# Make entrypoint script executable
RUN chmod +x /app/docker-entrypoint.sh

# Expose port
EXPOSE 8000

# Use entrypoint script
ENTRYPOINT ["/app/docker-entrypoint.sh"]

# Default command (use uv run to ensure correct environment)
CMD ["uv", "run", "gunicorn", "dolce_backend.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "4"]

