# Start

```
git clone git@github.com:drecken/laravel-react-pest-wayfinder-boost.git
cd laravel-react-pest-wayfinder-boost
docker compose up -d
docker compose exec -ti workspace ./scripts/create-laravel-project.sh
docker compose exec -ti workspace composer require laravel/boost --dev
```

## Install Boost

```
docker compose exec -ti workspace php artisan boost:install
``` 