FROM gcr.io/cadvisor/cadvisor:v0.60.5

LABEL prometheus_address="cadvisor:8080" \
      prometheus_scrape="true"
