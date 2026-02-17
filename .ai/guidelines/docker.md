# Docker Development Environment

PHP and Node.js are not installed locally. This project does not use Laravel Sail. All PHP and npm commands must be run inside the `workspace` Docker container.

```bash
# Example: install a Composer package
docker compose exec workspace composer require some/package

# Example: run npm
docker compose exec workspace npm install

# Example: run Artisan
docker compose exec workspace php artisan migrate

# Example: run tests
docker compose exec workspace php artisan test
```
