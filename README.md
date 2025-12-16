# Dolce Fiore

> Premium, handcrafted gift hampers rooted in health, sustainability, and conscious living.

[![Django](https://img.shields.io/badge/Django-5.0+-092E20?logo=django)](https://www.djangoproject.com/)
[![React](https://img.shields.io/badge/React-19.2.0-61DAFB?logo=react)](https://react.dev/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.9.3-3178C6?logo=typescript)](https://www.typescriptlang.org/)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker)](https://www.docker.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?logo=postgresql)](https://www.postgresql.org/)

## Table of Contents

- [About](#about)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Quick Start with Docker](#quick-start-with-docker)
- [Development Setup](#development-setup)
- [Environment Variables](#environment-variables)
- [API Documentation](#api-documentation)
- [Running the Application](#running-the-application)
- [Building for Production](#building-for-production)
- [Contributing](#contributing)
- [License](#license)

## About

**Dolce Fiore** is a premium e-commerce platform for handcrafted gift hampers that celebrate health, sustainability, and conscious living. Every product is designed to delight while leaving a positive impact on people and the planet.

### Brand Story

Dolce Fiore began as a homegrown venture with a simple dream — to craft thoughtful, sustainable gifting experiences. What started four years ago with a passion for healthy indulgence has grown into a celebration of creativity and conscious living.

Our hampers feature:
- **Organic, guilt-free treats** — Premium ingredients without compromise
- **Air-fried savories** — Healthier alternatives to traditional snacks
- **Sugar-free chocolates** — Indulgence without the guilt
- **Eco-friendly, reusable packaging** — Sustainable materials that become part of the gift

We proudly partner with local artisans across India, bringing tradition and sustainability into every creation.

## Current Status

- The Django backend is present with REST endpoints, management commands, and Docker setup.
- The React frontend is missing its entire `src/lib` folder (API client, endpoint definitions, hooks, and environment config). Multiple files import from this folder, so `npm run dev` or Docker builds will currently fail until the missing modules are restored.

## Features

### ✅ Implemented Features

#### 🏠 Frontend Features
- **Home Page** — Hero section, featured hampers, sustainable gifting, testimonials, brand story
- **Product Catalog** — Advanced filtering, search, sorting, responsive grid layout
- **Product Details** — Comprehensive product information with images and tags
- **Shopping Cart** — Add, remove, update quantities with real-time totals
- **Checkout Flow** — Multi-step process with customer details, shipping, and payment
- **Order Management** — Order history, status tracking, order details
- **About Us Page** — Dynamic content sections, photo gallery, blog posts
- **User Authentication** — Login, signup, profile management
- **Responsive Design** — Mobile-first approach, fully responsive across all devices

#### 🔧 Backend Features
- **Django REST Framework API** — RESTful API with comprehensive endpoints
- **User Authentication** — Session-based authentication
- **Product Management** — Products with images, tags, categories, filtering
- **Shopping Cart** — Cart management with quantity control
- **Order Management** — Order creation with customer and shipping details
- **Payment Integration** — Payment order creation (ready for Razorpay/Stripe)
- **Content Management** — Dynamic content for home page and About Us page
- **Admin Dashboard** — Django Admin for managing products, orders, and content
- **API Documentation** — Interactive Swagger UI documentation

## Technology Stack

### Backend
- **Django 5.0+** — Web framework
- **Django REST Framework** — REST API framework
- **PostgreSQL 16** — Production database
- **uv** — Python package manager
- **Gunicorn** — WSGI HTTP server
- **drf-spectacular** — OpenAPI/Swagger documentation

### Frontend
- **React 19.2.0** — UI library
- **TypeScript 5.9.3** — Type-safe JavaScript
- **Vite 7.2.4** — Build tool and dev server
- **Tailwind CSS 4.1.17** — Utility-first CSS framework
- **TanStack React Query** — Server state management
- **Zustand** — UI state management
- **React Router DOM** — Routing

### Infrastructure
- **Docker & Docker Compose** — Containerization
- **Nginx** — Reverse proxy and static file serving
- **PostgreSQL** — Database

## Project Structure

```
dolce-fiore/
├── backend/                 # Django backend application
│   ├── apps/               # Django apps
│   │   ├── users/         # User authentication
│   │   ├── products/      # Product catalog
│   │   ├── cart/          # Shopping cart
│   │   ├── orders/        # Order management
│   │   ├── payments/      # Payment processing
│   │   └── content/       # Content management
│   ├── dolce_backend/     # Django project settings
│   ├── manage.py
│   ├── pyproject.toml     # uv project configuration
│   ├── Dockerfile
│   └── docker-entrypoint.sh
├── frontend/              # React frontend application
│   ├── src/
│   │   ├── app/          # App root and routing
│   │   ├── components/  # Reusable UI components
│   │   ├── features/    # Feature-based modules
│   │   ├── lib/         # (Expected) API utilities and hooks — missing in current repo
│   │   └── mocks/       # Mock data and API handlers
│   ├── package.json
│   ├── Dockerfile
│   └── vite.config.ts
├── nginx/                 # Nginx configuration
│   ├── Dockerfile
│   ├── nginx.conf
│   ├── nginx-dev.conf
│   └── nginx-prod.conf
├── docker-compose.yml     # Docker Compose configuration
├── build-frontend.sh      # Frontend build script (Linux/Mac)
├── build-frontend.ps1     # Frontend build script (Windows)
├── .gitignore
└── README.md
```

## Prerequisites

Before you begin, ensure you have the following installed:

- **Docker** (version 20.10+) and **Docker Compose** (version 2.0+)
  - [Install Docker Desktop](https://www.docker.com/products/docker-desktop)
- **Git** — Version control
- **Node.js** (18.0.0+) — For local frontend development
- **Python 3.11+** — For local backend development
- **uv** — Python package manager (for local backend development)

## Quick Start with Docker

The easiest way to get started is using Docker Compose, which sets up all services automatically.

### 1. Clone the Repository

```bash
git clone <repository-url>
cd dolce-fiore
```

### 2. Set Up Environment Variables

Create a `.env` file in the root directory:

```env
# Django Settings
SECRET_KEY=your-secret-key-here-change-in-production
DJANGO_ENV=development
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1,backend,nginx

# Database Configuration
POSTGRES_DB=dolce_fiore
POSTGRES_USER=dolce_user
POSTGRES_PASSWORD=dolce_password
POSTGRES_PORT=5432

# CORS Configuration
CORS_ALLOWED_ORIGINS=http://localhost:5173,http://127.0.0.1:5173,http://frontend:5173,http://localhost,http://127.0.0.1,http://nginx

# Frontend Configuration
VITE_USE_MOCK_API=false
NODE_ENV=development
FRONTEND_TARGET=development

# Nginx Configuration
NGINX_ENV=development
NGINX_PORT=80
```

### 3. Start the Application

```bash
docker-compose up -d
```

This will:
- Start PostgreSQL database
- Build and start Django backend
- Build and start React frontend
- Start Nginx reverse proxy

### 4. Initialize the Database

```bash
# Run migrations
docker-compose exec backend uv run python manage.py migrate

# Create superuser (optional)
docker-compose exec backend uv run python manage.py create_superuser

# Load mock products (MANDATORY)
docker-compose exec backend uv run python manage.py load_mock_products
```

### 5. Access the Application

- **Frontend**: http://localhost
- **Backend API**: http://localhost/api
- **API Documentation (Swagger)**: http://localhost/api/docs/
- **Django Admin**: http://localhost/admin/

### 6. View Logs

```bash
# View all logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f backend
docker-compose logs -f frontend
docker-compose logs -f nginx
```

### 7. Stop the Application

```bash
docker-compose down
```

To also remove volumes (database data will be lost):

```bash
docker-compose down -v
```

## Development Setup

For local development without Docker, follow these steps:

### Backend Setup

1. **Navigate to backend directory**
   ```bash
   cd backend
   ```

2. **Install uv** (if not installed)
   ```bash
   # Windows (PowerShell)
   powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
   
   # macOS/Linux
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

3. **Install dependencies**
   ```bash
   uv sync
   ```

4. **Set up environment variables**
   Create a `.env` file in the `backend/` directory:
   ```env
   SECRET_KEY=your-secret-key-here
   DEBUG=True
   ALLOWED_HOSTS=localhost,127.0.0.1
   CORS_ALLOWED_ORIGINS=http://localhost:5173,http://127.0.0.1:5173
   DB_NAME=dolce_fiore
   DB_USER=dolce_user
   DB_PASSWORD=dolce_password
   DB_HOST=localhost
   DB_PORT=5432
   ```

5. **Set up PostgreSQL** (or use SQLite for development)
   - Install PostgreSQL 16
   - Create database: `createdb dolce_fiore`
   - Or modify settings to use SQLite

6. **Run migrations**
   ```bash
   uv run python manage.py migrate
   ```

7. **Create superuser**
   ```bash
   uv run python manage.py create_superuser
   ```

8. **Load mock products**
   ```bash
   uv run python manage.py load_mock_products
   ```

9. **Start the development server**
   ```bash
   uv run python manage.py runserver
   ```

   Backend will be available at: http://localhost:8000

### Frontend Setup

1. **Navigate to frontend directory**
   ```bash
   cd frontend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables** (optional)
   Create a `.env` file in the `frontend/` directory:
   ```env
   VITE_API_BASE_URL=http://localhost:8000/api
   VITE_USE_MOCK_API=false
   ```

4. **Start the development server**
   ```bash
   npm run dev
   ```

   Frontend will be available at: http://localhost:5173

## Environment Variables

### Backend Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `SECRET_KEY` | Django secret key | Required |
| `DJANGO_ENV` | Environment (development/production) | `development` |
| `DEBUG` | Debug mode | `True` |
| `ALLOWED_HOSTS` | Allowed host headers | `localhost,127.0.0.1` |
| `DB_NAME` | PostgreSQL database name | `dolce_fiore` |
| `DB_USER` | PostgreSQL username | `dolce_user` |
| `DB_PASSWORD` | PostgreSQL password | `dolce_password` |
| `DB_HOST` | PostgreSQL host | `db` (Docker) / `localhost` (local) |
| `DB_PORT` | PostgreSQL port | `5432` |
| `CORS_ALLOWED_ORIGINS` | CORS allowed origins | `http://localhost:5173` |

### Frontend Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `VITE_API_BASE_URL` | Backend API base URL | `http://localhost:8000/api` |
| `VITE_USE_MOCK_API` | Use mock API (MSW) | `false` |
| `NODE_ENV` | Node environment | `development` |

## API Documentation

Once the backend is running, access the interactive API documentation:

- **Swagger UI**: http://localhost/api/docs/ (or http://localhost:8000/api/docs/ in local dev)
- **OpenAPI Schema**: http://localhost/api/schema/ (or http://localhost:8000/api/schema/ in local dev)

### Main API Endpoints

#### Authentication
- `POST /api/auth/login` — User login
- `POST /api/auth/signup` — User registration
- `POST /api/auth/logout` — User logout

#### Products
- `GET /api/products` — List all products (with filtering, search, sorting)
- `GET /api/products/{slug}` — Get product by slug

#### Cart
- `GET /api/cart` — Get user's cart
- `POST /api/cart` — Add item to cart
- `PUT /api/cart/{id}` — Update cart item quantity
- `DELETE /api/cart/{id}/delete` — Remove item from cart

#### Orders
- `GET /api/orders` — List user's orders
- `POST /api/orders` — Create new order

#### Payments
- `POST /api/payments/create-order` — Create payment order

#### Content
- `GET /api/content/sustainable-gifting/` — Get sustainable gifting items
- `GET /api/content/testimonials/text/` — Get text testimonials
- `GET /api/content/testimonials/video/` — Get video testimonials
- `GET /api/content/about-us/` — Get About Us section
- `GET /api/content/our-story/` — Get Our Story section
- `GET /api/content/our-commitment/` — Get Our Commitment sections
- `GET /api/content/photo-gallery/` — Get photo gallery items
- `GET /api/content/blogs/` — Get blog posts

For detailed API documentation, see:
- [Backend README](backend/README.md)
- [Frontend README](frontend/README.md)

## Running the Application

### Development Mode (Docker)

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Production Mode (Docker)

1. **Build frontend static files**
   ```bash
   # Linux/Mac
   ./build-frontend.sh
   
   # Windows
   .\build-frontend.ps1
   ```

2. **Set environment variables**
   ```env
   NGINX_ENV=production
   FRONTEND_TARGET=production
   DJANGO_ENV=production
   DEBUG=False
   ```

3. **Start services**
   ```bash
   docker-compose up -d
   ```

### Local Development (Without Docker)

1. **Start PostgreSQL** (if using PostgreSQL)
2. **Start backend**: `cd backend && uv run python manage.py runserver`
3. **Start frontend**: `cd frontend && npm run dev`

## Building for Production

### Frontend Production Build

```bash
cd frontend
npm run build
```

This creates an optimized production build in the `frontend/dist/` directory.

### Docker Production Build

```bash
# Build frontend static files
./build-frontend.sh  # or .\build-frontend.ps1 on Windows

# Start with production settings
NGINX_ENV=production FRONTEND_TARGET=production docker-compose up -d
```

## Contributing

Contributions are welcome! Please follow these guidelines:

1. **Fork the repository** and create a feature branch
2. **Follow code style** — Use ESLint (frontend) and follow Django conventions (backend)
3. **Write tests** — Ensure new features have test coverage
4. **Update documentation** — Keep README and code comments up to date
5. **Submit a pull request** — Describe your changes clearly

### Development Guidelines

- Follow the existing code structure and patterns
- Maintain TypeScript strict mode compliance (frontend)
- Ensure mobile-first responsive design
- Keep components small and focused
- Write meaningful commit messages
- Test your changes locally before submitting

## License

This project is private and proprietary. All rights reserved.

---

**Built with ❤️ in India**

For questions or support, please contact the development team.

