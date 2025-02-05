# LAN Cache Server Installation Guide

This guide provides step-by-step instructions for installing and configuring a LAN Cache server using Docker and Docker Compose.

## **Table of Contents**
- [Prerequisites](#prerequisites)
- [Docker Installation](#docker-installation)
- [Portainer Setup](#portainer-setup)
- [LAN Cache Setup](#lan-cache-setup)
- [Configuration](#configuration)
- [Deploying LAN Cache](#deploying-lan-cache)
- [Monitoring](#monitoring)

---

## **Prerequisites**
Ensure your system is updated and has the necessary dependencies installed:

```sh
apt update && apt upgrade -y
apt install curl git nano -y
```

---

## **Docker Installation**
Install Docker and Docker Compose:

```sh
curl -sSL https://get.docker.com/ | sh
systemctl status docker.service
apt install docker-compose -y
```

---

## **Portainer Setup**
Portainer is a web-based container management tool. Install and run Portainer with the following commands:

```sh
mkdir /data
cd /data
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 \
  --name portainer --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data portainer/portainer-ce:latest
```

---

## **LAN Cache Setup**
Clone the LAN Cache repository and configure the environment:

```sh
git clone https://github.com/lancachenet/docker-compose/ lancache
cd lancache
nano .env
```

Update the `.env` file with the following values:

```ini
USE_GENERIC_CACHE=true
LANCACHE_IP=172.16.172.14
DNS_BIND_IP=172.16.172.14
UPSTREAM_DNS=8.8.8.8; 9.9.9.9; 1.1.1.1
CACHE_ROOT=./lancache
CACHE_MEM_SIZE=65536m
CACHE_DISK_SIZE=4500g
CACHE_SLICE_SIZE=4m
CACHE_MAX_AGE=120d
TZ=Asia/Dhaka
```

---

## **Configuration**
Create or edit the `docker-compose.yml` file:

```sh
nano docker-compose.yml
```

Add the following configuration:

```yaml
version: '2'
services:
  dns:
    image: lancachenet/lancache-dns:latest
    env_file: .env
    restart: always
    ports:
      - ${DNS_BIND_IP}:53:53/udp
      - ${DNS_BIND_IP}:53:53/tcp
  monolithic:
    image: lancachenet/monolithic:latest
    env_file: .env
    restart: always
    ports:
      - 172.16.172.14:80:80/tcp
      - 172.16.172.14:443:443/tcp
    volumes:
      - ${CACHE_ROOT}/cache:/data/cache
      - ${CACHE_ROOT}/logs:/data/logs
      - ${CACHE_ROOT}/custom.db:/etc/bind/cache/custom.db
```

---

## **Deploying LAN Cache**
Start the LAN Cache services using Docker Compose:

```sh
docker-compose up -d
```

---

## **Monitoring**
Check the running containers and monitor resource usage:

```sh
docker stats
```

---

## **Conclusion**
Your LAN Cache server is now set up and running. This setup will help optimize bandwidth usage by caching frequently downloaded game files.

For further customization and troubleshooting, refer to the [LANCache GitHub repository](https://github.com/lancachenet/docker-compose/).

