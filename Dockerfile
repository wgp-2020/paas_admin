FROM nginx:1.24.0

ARG PORT
ARG USERNAME
ARG PASSWORD
ARG UUID
ARG PATH_VLESS
ARG PATH_VMESS
ARG WARP_SERVER
ARG WARP_KEY
ARG TUNNEL

ENV PORT=$PORT
ENV USERNAME=$USERNAME
ENV PASSWORD=$PASSWORD
ENV UUID=$UUID
ENV PATH_VLESS=$PATH_VLESS
ENV PATH_VMESS=$PATH_VMESS
ENV WARP_SERVER=$WARP_SERVER
ENV WARP_KEY=$WARP_KEY
ENV TUNNEL=$TUNNEL

EXPOSE 80
COPY main/ /app/
WORKDIR /root

RUN chmod +x /app/cmd/* /app/config/* /app/init.sh && \ 
    if [ -f /app/config/sources.list ]; then mv /app/config/sources.list /etc/apt/sources.list; fi && \
    apt update && apt install -y procps cron
    
CMD ["/bin/bash","-c",". /app/config/export.sh && /app/init.sh"]
