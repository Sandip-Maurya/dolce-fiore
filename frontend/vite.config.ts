import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
// Determine backend URL based on environment
// In Docker, use service name; locally, use localhost
// VITE_API_BASE_URL from env will be like "http://backend:8000/api"
// We need to extract just the base URL without /api for the proxy target
const getBackendUrl = (): string => {
  const apiBaseUrl = process.env.VITE_API_BASE_URL
  if (apiBaseUrl) {
    // Remove /api suffix if present, or use as-is
    return apiBaseUrl.replace(/\/api\/?$/, '')
  }
  // Default: use backend service name in Docker, localhost locally
  // Docker Compose sets service names, so 'backend' will resolve
  return process.env.NODE_ENV === 'production' || process.env.DOCKER_ENV === 'true'
    ? 'http://backend:8000'
    : 'http://127.0.0.1:8000'
}

export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0', // Allow external connections (needed for Docker)
    proxy: {
      // Proxy API requests to Django backend
      // This makes API requests appear same-origin, so cookies work properly
      '/api': {
        target: getBackendUrl(),
        changeOrigin: true,
        secure: false,
        // Preserve the /api prefix when forwarding
        rewrite: (path) => path,
      },
    },
  },
})
