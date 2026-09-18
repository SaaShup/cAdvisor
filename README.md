# saashup/cAdvisor

Repackages `gcr.io/cadvisor/cadvisor` as a versioned, buildable
image + compose service.

- `Dockerfile` → static metadata (Prometheus scrape labels).
- `docker-compose.yml` → everything host-specific.

## Prerequisites

The `traefik` (or whatever you name it via `WEB_NET`) Docker network
must already exist, e.g.:

```bash
docker network create --driver bridge --subnet 172.31.0.0/16 traefik
```

## Usage

```bash 
docker compose up -d --build
```
or 

```bash
docker run -d \
  --name cadvisor \
  --restart unless-stopped \
  --privileged \
  --network traefik \
  --device /dev/kmsg \
  --label prometheus_address=cadvisor:8080 \
  --label prometheus_scrape=true \
  -v /:/rootfs:ro \
  -v /var/run:/var/run:rw \
  -v /sys:/sys:ro \
  -v /var/lib/docker:/var/lib/docker:ro \
  --log-driver syslog \
  --log-opt syslog-address=udp://127.0.0.1:5514 \
  --log-opt tag="{{.Name}}" \
  ghcr.io/saashup/cadvisor:latest
```

Metrics are exposed on the container's `:8080/metrics`, reachable from
other containers on the same network as `http://cadvisor:8080/metrics`.
