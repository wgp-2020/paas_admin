#!/bin/bash

export PORT=${PORT:-80}
export USERNAME=${USERNAME:-admin}
export PASSWORD=${PASSWORD:-admin}
export UUID=${UUID:-1eb6e917-774b-4a84-aff6-b058577c60a5}
export PATH_VLESS=${PATH_VLESS:-/$UUID/vless}
export PATH_VMESS=${PATH_VMESS:-/$UUID/vmess}
export WARP_SERVER=${WARP_SERVER:-engage.cloudflareclient.com}
export WARP_KEY=${WARP_KEY}
export TUNNEL=${TUNNEL:-0}
