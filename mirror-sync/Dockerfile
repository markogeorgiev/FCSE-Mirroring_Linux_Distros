FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y rsync nginx-light cron && \
    mkdir -p /var/www/html && \
    touch /var/log/sync.log

COPY sync.sh /usr/local/bin/sync.sh
RUN chmod +x /usr/local/bin/sync.sh

COPY start.sh /start.sh
RUN chmod +x /start.sh

COPY nginx.conf /etc/nginx/nginx.conf

# Create the cron job
RUN printf 'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\n'\
          '0 * * * * root /usr/local/bin/sync.sh >> /var/log/sync.log 2>&1\n' \
          > /etc/cron.d/mirrorcron && chmod 0644 /etc/cron.d/mirrorcron

CMD ["/start.sh"]
