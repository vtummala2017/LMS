#!/usr/bin/env bash
cd "$(dirname "$0")"
mkdir -p backups
docker compose exec -T db pg_dump -U whiteboard whiteboard | gzip > backups/db-$(date +%F).sql.gz
find backups -type f -mtime +14 -delete
