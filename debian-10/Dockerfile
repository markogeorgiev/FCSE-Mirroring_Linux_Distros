FROM debian:10

# Switch apt sources to archive.debian.org with trusted=yes to bypass no Release-file error
RUN sed -i 's|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

RUN apt-get update && apt-get install -y rsync nginx cron && \
    mkdir -p /var/www/html/debian-10 && touch /var/log/sync.log

COPY sync.sh /usr/local/bin/sync.sh
RUN chmod +x /usr/local/bin/sync.sh

COPY default.conf /etc/nginx/sites-available/default
COPY nginx.conf /etc/nginx/nginx.conf
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Cron entries: run sync every 6 hours (four times/day, per Debian mirror guidelines) :contentReference[oaicite:5]{index=5}
RUN echo "SHELL=/bin/bash\nPATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin\n0 */6 * * * root /usr/local/bin/sync.sh >> /var/log/sync.log 2>&1" \
    > /etc/cron.d/mirrorcron && \
    chmod 0644 /etc/cron.d/mirrorcron

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
