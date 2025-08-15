#!/bin/sh
set -e

: "${DB_HOST:?Set DB_HOST}"
: "${DB_USER:?Set DB_USER}"
: "${DB_PASSWORD:?Set DB_PASSWORD}"
: "${DB_NAME:=wordpress}"

echo "⏳ waiting for DB at ${DB_HOST} as ${DB_USER}..."
php -r '
$h=getenv("DB_HOST"); $u=getenv("DB_USER"); $p=getenv("DB_PASSWORD"); $d=getenv("DB_NAME");
$timeout=120; $start=time();
do {
  $m=@mysqli_init();
  @mysqli_options($m, MYSQLI_OPT_CONNECT_TIMEOUT, 5);
  @$m->real_connect($h,$u,$p,$d,3306);
  if (mysqli_connect_errno()) { fwrite(STDERR, "waiting: ".mysqli_connect_error()."\n"); sleep(2); }
} while (mysqli_connect_errno() && (time()-$start)<$timeout);
if (mysqli_connect_errno()) { fwrite(STDERR,"❌ DB still unreachable\n"); exit(1); }
'
echo "✅ DB reachable. Starting PHP server on :8080"
exec php -S 0.0.0.0:8080 -t /var/local/wordpress
