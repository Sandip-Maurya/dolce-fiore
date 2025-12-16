#!/bin/bash
set -e

# Ensure dependencies are installed (needed when source code is mounted in development)
if [ ! -d ".venv" ] || [ ! -f "pyproject.toml" ]; then
  echo "Virtual environment not found or pyproject.toml missing, syncing dependencies..."
  uv sync --frozen --no-install-project || uv sync --no-install-project
fi

echo "Waiting for database to be ready..."
# Wait for PostgreSQL to be ready (only if DB_NAME is set, meaning we're using PostgreSQL)
if [ -n "${DB_NAME}" ]; then
  until PGPASSWORD="${DB_PASSWORD}" psql -h "${DB_HOST}" -U "${DB_USER}" -d "${DB_NAME}" -c '\q' 2>/dev/null; do
    >&2 echo "PostgreSQL is unavailable - sleeping"
    sleep 1
  done
  
  >&2 echo "PostgreSQL is up - executing commands"
else
  >&2 echo "Using SQLite database (no wait needed)"
fi

# Run migrations
echo "Running database migrations..."
uv run python manage.py migrate --noinput

# Collect static files
echo "Collecting static files..."
uv run python manage.py collectstatic --noinput

# Create superuser if it doesn't exist (optional, can be done manually)
# Uncomment the following lines if you want to auto-create a superuser
# echo "Creating superuser if needed..."
# uv run python manage.py create_superuser || true

# Execute the command passed to the container
exec "$@"

