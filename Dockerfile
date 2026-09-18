FROM gcr.io/cadvisor/cadvisor:v0.55.1

LABEL prometheus_address="cadvisor:8080" \
      prometheus_scrape="true"
