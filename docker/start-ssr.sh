#!/bin/bash

# Wait for dependencies
while [ ! -d /app/vendor ] || [ ! -d /app/node_modules ]; do
    echo "[ssr] Waiting for dependencies..."
    sleep 5
done

cd /app

# Build SSR bundle if missing
if [ ! -f /app/bootstrap/ssr/ssr.js ]; then
    echo "[ssr] Building SSR bundle..."
    npm run build:ssr
fi

exec php artisan inertia:start-ssr
