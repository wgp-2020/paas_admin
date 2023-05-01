FROM nginx:1.24.0

ENV PORT=$PORT \
	USERNAME=$USERNAME \
	PASSWORD=$PASSWORD \
	UUID=$UUID \
	PATH_VLESS=$PATH_VLESS \
	PATH_VMESS=$PATH_VMESS \
	WARP_SERVER=$WARP_SERVER \
	WARP_KEY=$WARP_KEY \
	TUNNEL=$TUNNEL

EXPOSE $PORT

COPY main/ /app/

WORKDIR /root

RUN if [ -f /app/config/sources.list ]; then mv /app/config/sources.list /etc/apt/sources.list; fi && \
    apt update && apt install -y procps cron && \
    chmod +x /app/cmd/* /app/init.sh

CMD ["/bin/bash","-c",". /app/init.sh"]