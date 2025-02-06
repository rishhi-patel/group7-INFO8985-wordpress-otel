# signoz
signoz demo with docker-compose 

```bash
docker compose up -d
```

This brings up an "empty" signoz on port 3301 in a codespace. It also brings up wordpress on port 8000 amd adminer on port 8001. Use this as a starting point for instrumenting your app. https://docs.splunk.com/observability/en/gdi/opentelemetry/components/sqlquery-receiver.html should be helpful.

I also used this for a demo I was doing. To do this, I added an nginx proxy in the nginx folder and added the container with `- ./nginx/docker-compose.yml` in the `docker-compose.yml` file.

