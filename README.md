# Laravel + React + Pest + Wayfinder + Boost

A one-line installer for a Docker-based Laravel development environment with React, Pest testing, Wayfinder, and Boost.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/drecken/laravel-react-pest-wayfinder-boost/main/install.sh | bash -s my-project
```

Replace `my-project` with your desired project directory name.

After installation, run the Boost installer:

```bash
cd my-project
docker compose exec -ti workspace php artisan boost:install
```

## What's Included

- **Laravel** with React frontend (Inertia.js)
- **Pest** testing framework
- **Wayfinder** for type-safe routing
- **Boost** for AI-powered development
- **Docker** environment with PHP 8.3, Node.js, and Nginx
