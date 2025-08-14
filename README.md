# Wordpress Micro Frontend
consume microfrontends and do distributed tracing with OTEL 

```bash
docker compose up -d
```

Use this as a starting point for instrumenting your app. https://docs.splunk.com/observability/en/gdi/opentelemetry/components/sqlquery-receiver.html should be helpful.

Use https://github.com/diy-pwa/one-click-child-theme to enqueue the micro frontend code. Be careful to not edit the functions.php of the current theme.

There is also another article that shgould be helpful https://signoz.io/docs/instrumentation/opentelemetry-wordpress/
