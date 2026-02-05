# Docker Development Environment

This project uses Docker for development. All commands must be run inside the workspace container.

## Running Commands

Instead of running commands directly on the host:
```bash
# DON'T do this
php artisan migrate
npm run dev
composer install
```

Use Docker Compose exec:
```bash
# DO this instead
docker compose exec workspace php artisan migrate
docker compose exec workspace npm run dev
docker compose exec workspace composer install
```

## Common Commands

- **Artisan**: `docker compose exec workspace php artisan <command>`
- **Composer**: `docker compose exec workspace composer <command>`
- **NPM**: `docker compose exec workspace npm <command>`
- **Tinker**: `docker compose exec workspace php artisan tinker`
- **Tests**: `docker compose exec workspace php artisan test`

## Service URLs

- Application: `http://{APP_NAME}.localhost` (via Traefik)
- All requests route through nginx to the workspace container
