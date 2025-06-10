#!/bin/bash

set -e

echo "🚀 Setting up Laravel + Vue development environment..."

# Install Composer with proper permissions
curl -sS https://getcomposer.org/installer | php -- --install-dir=/tmp --filename=composer
sudo mv /tmp/composer /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

# Install Git (should already be there, but just in case)
sudo apt-get update && sudo apt-get install -y git

# Create Laravel project if it doesn't exist
if [ ! -f "composer.json" ]; then
    echo "📦 Creating new Laravel project..."
    
    # Create Laravel in a temporary directory
    cd /tmp
    composer create-project laravel/laravel laravel-temp --prefer-dist --no-interaction
    
    # Move Laravel files to workspace (excluding .git to preserve our repo)
    cd laravel-temp
    cp -r . /workspace/
    cd /workspace
    rm -rf /tmp/laravel-temp
    
    # Install Laravel Breeze with Vue
    composer require laravel/breeze --dev
    php artisan breeze:install vue --no-interaction
    
    # Install npm dependencies
    npm install
fi

# Set proper permissions
sudo chown -R vscode:vscode /workspace
chmod -R 755 /workspace

# Copy environment file if it doesn't exist
if [ ! -f ".env" ]; then
    cp .env.example .env
fi

# Update .env with correct database settings
sed -i 's/DB_HOST=127.0.0.1/DB_HOST=mysql/' .env
sed -i 's/DB_DATABASE=laravel/DB_DATABASE=laravel_app/' .env
sed -i 's/DB_USERNAME=root/DB_USERNAME=laravel_user/' .env
sed -i 's/DB_PASSWORD=/DB_PASSWORD=laravel_password/' .env

# Wait for MySQL to be ready
echo "⏳ Waiting for MySQL to be ready..."
while ! mysqladmin ping -h mysql -u laravel_user -plaravel_password --silent 2>/dev/null; do
    sleep 1
done

# Generate application key and run migrations
php artisan key:generate --no-interaction
php artisan migrate --no-interaction --force

echo "✅ Development environment ready!"
echo "🌐 Run 'php artisan serve --host=0.0.0.0' to start Laravel"
echo "🎨 Run 'npm run dev -- --host' to start Vite"
