#!/bin/bash

echo 'server {
    listen       '${PORT}' default_server;
    listen  [::]:'${PORT}' default_server;
    server_name  _;

    client_max_body_size 9999g;

    proxy_http_version 1.1;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";

    location '${PATH_VLESS}' {
        if ($http_upgrade != "websocket") {
	    	return 301 $scheme://$host/;
	    }
    	proxy_pass http://127.0.0.1:2001;
    }

    location '${PATH_VMESS}' {
    	if ($http_upgrade != "websocket") {
	    	return 301 $scheme://$host/;
	    }
    	proxy_pass http://127.0.0.1:2002;
    }

    location /shell {
        proxy_pass http://127.0.0.1:7681/;
    }

    location / {
        proxy_pass http://127.0.0.1:8080/;
    }
}' > /etc/nginx/conf.d/default.conf

service nginx restart
