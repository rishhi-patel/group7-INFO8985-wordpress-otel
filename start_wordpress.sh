#!/bin/sh
[ ! -d "wp-content/index.php" ] && cp -r wp-content.bak/* wp-content/
php -S 0.0.0.0:8000