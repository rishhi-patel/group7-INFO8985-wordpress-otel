#!/bin/sh
[ ! -d "wp-content/index.php" ] && cp -r wp-content.bak/* wp-content/

# Install composer dependencies if not present
if [ ! -d "vendor" ]; then
    echo "Installing Composer dependencies..."
    composer install --no-dev --optimize-autoloader
fi

# Check if vendor directory exists and autoload file is present
if [ ! -f "vendor/autoload.php" ]; then
    echo "Error: vendor/autoload.php not found. Installing dependencies..."
    composer install --no-dev --optimize-autoloader
fi

echo "Starting WordPress server..."
php -S 0.0.0.0:8000