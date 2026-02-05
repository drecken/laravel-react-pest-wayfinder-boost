import tailwindcss from '@tailwindcss/vite';
import react from '@vitejs/plugin-react';
import laravel from 'laravel-vite-plugin';
import { defineConfig, loadEnv } from 'vite';

export default defineConfig(({ mode }) => {
    const env = loadEnv(mode, process.cwd(), '');
    const appUrl = new URL(env.APP_URL || 'http://localhost');

    return {
        server: {
            host: '0.0.0.0',
            port: 5173,
            strictPort: true,
            hmr: {
                host: appUrl.hostname,
                protocol: appUrl.protocol === 'https:' ? 'wss' : 'ws',
                clientPort: appUrl.port ? parseInt(appUrl.port) : (appUrl.protocol === 'https:' ? 443 : 80),
            },
        },
        plugins: [
            laravel({
                input: ['resources/css/app.css', 'resources/js/app.tsx'],
                refresh: true,
            }),
            react(),
            tailwindcss(),
        ],
    };
});
