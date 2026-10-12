#!/usr/bin/env bash
# Self-hosting: run on a fresh Ubuntu server with  bash install.sh
set -e
cd "$(dirname "$0")"
command -v docker >/dev/null 2>&1 || curl -fsSL https://get.docker.com | sh
if [ ! -f .env ]; then
  read -p "Your website address (e.g. lms.myschool.edu): " DOMAIN
  printf "DOMAIN=%s\nPOSTGRES_PASSWORD=%s\nSECRET_KEY=%s\n" "$DOMAIN" "$(openssl rand -hex 16)" "$(openssl rand -hex 32)" > .env
fi
docker compose up -d --build
chmod +x backup.sh
( crontab -l 2>/dev/null | grep -v whiteboard-backup; echo "0 2 * * * $(pwd)/backup.sh # whiteboard-backup" ) | crontab -
echo "Done. Open https://$(grep ^DOMAIN= .env | cut -d= -f2). The FIRST account you register becomes the admin."
