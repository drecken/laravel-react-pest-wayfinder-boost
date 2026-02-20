# Docker Development Environment

PHP and Node.js are not installed locally. This project does not use Laravel Sail.
All commands must be run inside the `workspace` Docker container.

## Helper Scripts

Use the scripts in the `scripts/` directory:

```bash
scripts/artisan migrate          # Run artisan commands
scripts/test                     # Run tests
scripts/test --filter=MyTest     # Run specific tests
scripts/npm install              # Install npm packages
scripts/composer require foo/bar # Install composer packages
scripts/php script.php           # Run PHP scripts
scripts/tinker                   # Open Laravel tinker
scripts/log                      # Tail Laravel log
scripts/exec <any-command>       # Run any command in workspace
```

## Direct Docker Commands

The scripts are wrappers around `docker compose exec workspace`:

```bash
docker compose exec workspace php artisan migrate
docker compose exec workspace npm install
```
