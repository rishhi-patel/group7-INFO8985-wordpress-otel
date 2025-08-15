<?php
/**
 * WordPress base configuration
 */

# ---------------------- DB from env ----------------------
define('DB_NAME',     getenv('DB_NAME')     ?: 'wordpress');
define('DB_USER',     getenv('DB_USER')     ?: 'wordpress');
define('DB_PASSWORD', getenv('DB_PASSWORD') ?: 'Secret5555');
define('DB_HOST',     getenv('DB_HOST')     ?: 'db');
define('DB_CHARSET',  'utf8');
define('DB_COLLATE',  '');

# ---------------------- Keys & salts (dev defaults; replace for prod) ----------------------
define( 'AUTH_KEY',         'change-this-key' );
define( 'SECURE_AUTH_KEY',  'change-this-key' );
define( 'LOGGED_IN_KEY',    'change-this-key' );
define( 'NONCE_KEY',        'change-this-key' );
define( 'AUTH_SALT',        'change-this-key' );
define( 'SECURE_AUTH_SALT', 'change-this-key' );
define( 'LOGGED_IN_SALT',   'change-this-key' );
define( 'NONCE_SALT',       'change-this-key' );

# ---------------------- Table prefix ----------------------
$table_prefix = 'wp_';

# ---------------------- Debug ----------------------
define('WP_DEBUG', false);

# ---------------------- Reverse proxy normalization ----------------------
if (!empty($_SERVER['HTTP_X_FORWARDED_HOST'])) {
    $_SERVER['HTTP_HOST'] = $_SERVER['HTTP_X_FORWARDED_HOST'];
}
if (!empty($_SERVER['HTTP_X_FORWARDED_PROTO'])) {
    $_SERVER['HTTPS'] = $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https' ? 'on' : '';
}

# ---------------------- Force public base URL ----------------------
$__home    = getenv('WP_HOME')    ?: 'http://localhost:8086';
$__siteurl = getenv('WP_SITEURL') ?: $__home;
define('WP_HOME',    $__home);
define('WP_SITEURL', $__siteurl);

# Optional: ensure content URL is absolute (avoid relative path issues)
if (!defined('WP_CONTENT_URL')) {
    define('WP_CONTENT_URL', rtrim(WP_HOME, '/').'/wp-content');
}

# Direct FS writes inside container
define('FS_METHOD', 'direct');

# ---------------------- Bootstrap ----------------------
if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}
require_once ABSPATH . 'wp-settings.php';
