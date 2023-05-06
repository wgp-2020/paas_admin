#!/bin/bash

# 环境变量
export APP_DIR=$(dirname ${BASH_SOURCE[0]})
export PATH=$PATH:$APP_DIR/cmd
# export USERNAME=${USERNAME-admin}     
# export PASSWORD=${PASSWORD-admin}
export SB_LOG="$APP_DIR/logs/sb.log"
export CF_LOG="$APP_DIR/logs/cf.log"

# 更新
cloudflared update

# shell终端
pkill -f "ttyd"
nohup ttyd -c ${USERNAME}:${PASSWORD} bash &>/dev/null & disown

# 文件浏览器
pkill -f "filebrowser" 
nohup filebrowser --username ${USERNAME} --password $(filebrowser hash ${PASSWORD}) -a 0.0.0.0 -r / -d ${APP_DIR}/gen/filebrowser.db &>/dev/null & disown
# filebrowser users update ${USERNAME} -p ${PASSWORD}

# 代理
. proxy

# nginx
chmod +x $APP_DIR/config/nginx.sh && $APP_DIR/config/nginx.sh

# 定时清理日志
cp $APP_DIR/config/clearlog /etc/cron.d/
crontab /etc/cron.d/clearlog
service cron restart

# 前台输出
if [ "$TUNNEL" = "1" ]; then
  # 运行隧道并输出隧道日志
  tunnel && tunnel -t
else
  # 输出代理日志
  proxy -t
fi
