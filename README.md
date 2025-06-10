# Laravel + Vue Hello World

A development environment using Dev Containers with Laravel, Vue.js, and MySQL.

## Getting Started

1. Open this folder in VS Code
2. Click "Reopen in Container" when prompted (or press F1 and search "Dev Containers: Reopen in Container")
3. Wait for the container to build and setup to complete (5-10 minutes first time)
4. Open two terminals in VS Code:
   - Terminal 1: `php artisan serve --host=0.0.0.0`
   - Terminal 2: `npm run dev -- --host`
5. Open http://localhost:8000 in your browser

## What's Included

- PHP 8.2
- Laravel 10 with Breeze authentication
- Vue.js 3 with Vite
- MySQL 8.0
- Node.js 18
- All necessary VS Code extensions

## Development

- Laravel runs on http://localhost:8000
- Vite dev server runs on http://localhost:5173
- MySQL available on localhost:3306

## Authentication

Laravel Breeze provides authentication out of the box:
- Visit /login or /register
- Default scaffolding includes Vue components
