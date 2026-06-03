#!/bin/bash
set -e

DOMAIN=callcapture.com
EMAIL=galacheck2@gmail.com

mkdir -p /var/www/certbot

if [ ! -f "/etc/letsencrypt/live/${DOMAIN}/fullchain.pem" ]; then
  certbot certonly \
    --webroot \
    -w /var/www/certbot \
    -d ${DOMAIN} \
    -d www.${DOMAIN} \
    --email ${EMAIL} \
    --agree-tos \
    --non-interactive
fi

(
  while true; do
    certbot renew --quiet
    sleep 12h
  done
) &

nginx -g "daemon off;"