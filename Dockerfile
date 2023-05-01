FROM nginx:1.24.0

EXPOSE 80
COPY main/ /app/
WORKDIR /root

RUN chmod +x /app/cmd/* /app/config/* /app/init.sh && \ 
    if [ -f /app/config/sources.list ]; then mv /app/config/sources.list /etc/apt/sources.list; fi && \
    apt update && apt install -y procps cron
    
CMD ["/bin/bash","-c",". /app/config/export.sh && /app/init.sh"]