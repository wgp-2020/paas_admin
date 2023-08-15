# PaaS_Admin

用于在各大PaaS平台部署的docker项目，所有配置均提供默认值即可快速部署，也可在运行容器时单独修改

**功能介绍**

- 文件浏览器：支持上传，下载，在线预览，文件分享，用户注册，等...
- shell终端：优秀的交互界面，完整的控制权
- 代理：基于sing-box通过vless与vmess协议代理
- 隧道 (入栈)：快速隧道，每次重启更换访问链接
- Warp (出栈)：提供密钥即可快速启用

**构建并上传镜像**

1. Fork当前仓库
2. 设置DockerHub账号 (必填)：Settings > Secrets and variables > Actions > 添加Secrets变量
   - DOCKERHUB_USERNAME：用户名
   - DOCKERHUB_PASSWORD：密码
   - IMAGE：镜像名称
     - 格式：`用户名/任意名称:任意标签`
     - 例如：zhangsan/demo:latest
   - <details>
      <summary>查看截图</summary>

      ![image](https://user-images.githubusercontent.com/70625361/235481645-60cbb1d3-806d-49d0-aa21-bbaf2d3aff82.png)
     </details>
3. 设置默认配置 (选填)：Settings > Secrets and variables > Actions > 添加Variables变量
   - <details>
      <summary>查看截图</summary>
      
      ![image](https://user-images.githubusercontent.com/70625361/235479087-2fa99315-84d9-480a-a49b-b9716245ba5d.png)
     </details>
4. 运行工作流：Actions > 构建镜像并推送 > Run workflow > Run workflow
   - <details>
      <summary>查看截图</summary>

      ![image](https://user-images.githubusercontent.com/70625361/235481505-0eff5199-48f3-4e08-91ae-224e379d4f1a.png)
     </details>
5. 运行完毕后：删除工作流记录，防止配置信息暴露

****

**代理**

Vless与Vmess配置

- 地址：平台提供 / cloudflare隧道
- 端口：通常为443
- 用户ID：1eb6e917-774b-4a84-aff6-b058577c60a5
- 传输协议：ws
- 路径：
  - Vless路径：/1eb6e917-774b-4a84-aff6-b058577c60a5/vless
  - Vmess路径：/1eb6e917-774b-4a84-aff6-b058577c60a5/vmess
- 传输层安全：tls

| 环境变量   | 默认值                               | 描述      | 可选 |
| ---------- | ------------------------------------ | --------- | ---- |
| UUID       | 1eb6e917-774b-4a84-aff6-b058577c60a5 | 用户ID    | 是   |
| PATH_VLESS | /${UUID}/vless                       | vless路径 | 是   |
| PATH_VMESS | /${UUID}/vmess                       | vmess路径 | 是   |

> `${UUID}`为环境变量UUID的值

****

**cloudflare**

- cloudflared tunnel：入栈隧道（内网穿透）
- warp：出站代理（解锁限制）

| 环境变量    | 默认值                      | 描述                     | 可选 |
| ----------- | --------------------------- | ------------------------ | ---- |
| TUNNEL      | 0                           | 是否启用隧道（0否，1是） | 是   |
| WARP_KEY    | 无                          | Warp私钥（PrivateKey）   | 是   |
| WARP_SERVER | engage.cloudflareclient.com | Warp服务器（Endpoint）   | 是   |

> 当`TUNNEL=1`时，容器日志将输出隧道日志（默认输出代理日志）

使用shell终端，重启隧道

```shell
tunnel && tunnel -t
```

使用shell终端，开关warp

```shell
# 设置变量（启用）
export WARP_KEY=****
# 删除变量（关闭）
unset WARP_KEY
# 重启代理
proxy
```

****

**项目访问路径**

- 文件浏览器：/
- shell终端：/shell

| 环境变量 | 默认值 | 描述   | 可选 |
| -------- | ------ | ------ | ---- |
| USERNAME | admin  | 用户名 | 是   |
| PASSWORD | admin  | 密码   | 是   |

****

**查看日志**

- 隧道
  - 持续输出最新日志：`tunnel -t`
  - 包含访问链接的日志：`tunnel -h`
- 代理
  - 持续输出最新日志：`proxy -t`

****

**端口**

| 环境变量 | 默认值 | 描述          | 可选 |
| -------- | ------ | ------------- | ---- |
| PORT     | 80     | nginx监听端口 | 是   |

> 服务占用端口：80,7681,8080,2001,2002

****

**镜像源**

修改构建时使用的软件包源：提供 `sources.list` 存放到 `main/config` 内

