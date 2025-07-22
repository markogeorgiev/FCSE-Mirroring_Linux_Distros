# Dockerfile for mirror-sync container with cron
FROM alpine:latest

RUN apk add --no-cache rsync bash curl coreutils tzdata

COPY sync.sh /scripts/sync.sh
RUN chmod +x /scripts/sync.sh

# Set up crontab to run sync.sh every 6 hours
RUN echo "0 */6 * * * /scripts/sync.sh >> /var/log/mirror-sync.log 2>&1" > /etc/crontabs/root

CMD ["crond", "-f"]