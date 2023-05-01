FROM nginx:1.24.0

ENV PORT=80

EXPOSE 80

COPY main/ /app/

WORKDIR /root

RUN if [ -f /app/config/sources.list ]; then mv /app/config/sources.list /etc/apt/sources.list; fi && \
    apt update && apt install -y procps cron && \
    chmod +x /app/cmd/* /app/init.sh

CMD ["/bin/bash","-c",". /app/init.sh"]