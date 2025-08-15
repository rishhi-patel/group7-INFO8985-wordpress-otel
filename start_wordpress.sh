#!/usr/bin/env sh
set -e

: "${DB_HOST:?Set DB_HOST}"
: "${DB_USER:?Set DB_USER}"
: "${DB_PASSWORD:?Set DB_PASSWORD}"
: "${DB_NAME:=wordpress}"

echo "⏳ Waiting for MySQL at ${DB_HOST}..."
until mariadb -h "$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "SELECT 1" >/dev/null 2>&1; do
  sleep 2
done
echo "✅ DB reachable."

# Ensure wp-content exists (in case of a blank volume)
mkdir -p /var/local/wordpress/wp-content

echo "🚀 Starting PHP server on :8080"
exec php -S 0.0.0.0:8080 -t /var/local/wordpress
