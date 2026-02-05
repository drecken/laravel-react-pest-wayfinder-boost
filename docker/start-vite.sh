#!/bin/bash

# Wait for package.json (project may not exist yet on fresh install)
while [ ! -f /app/package.json ]; do
    echo "[vite] Waiting for package.json..."
    sleep 5
done

# Wait for node_modules
while [ ! -d /app/node_modules ]; do
    echo "[vite] Waiting for node_modules..."
    sleep 5
done

cd /app
exec npm run dev -- --host 0.0.0.0
