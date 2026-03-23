#!/bin/bash
cd /var/www/hotelbot/hotelbot-landing
git pull origin main
docker compose down && docker compose up -d --build
echo "✅ HotelBot actualizado: $(date)"
