# Docker services (run via Colima)

Colima provides the Docker daemon. Start it with `colima start` (or autostart via
`brew services start colima`). These helper services run as containers.

## Portainer CE — web UI for Docker (containers/images/volumes/networks/stacks/k8s)
```bash
docker volume create portainer_data
docker run -d -p 9443:9443 -p 8000:8000 --name portainer --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data portainer/portainer-ce:latest
```
- Open **https://localhost:9443** (self-signed cert) → create the admin user **promptly**
  (Portainer disables first-time setup after a short timeout; `docker restart portainer` to reopen it).
- Control: `docker restart|stop|logs portainer`.
- Uninstall: `docker rm -f portainer && docker volume rm portainer_data`.

## Dockge (alternative) — clean UI focused on docker-compose stacks
```bash
mkdir -p ~/Developer/personal/dockge/{data,stacks}
docker run -d --name dockge --restart=always -p 5001:5001 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ~/Developer/personal/dockge/data:/app/data \
  -v ~/Developer/personal/dockge/stacks:/opt/stacks \
  louislam/dockge:1
# → http://localhost:5001
```

## Terminal alternative
`lazydocker` (already installed) — TUI, no browser needed.
