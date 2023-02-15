# docker-transmission

docker镜像链接：https://hub.docker.com/r/baozaodetudou/transmission

```shell
docker run -d \
  --name=transmission \
  -e UID=0 \
  -e GID=0 \
  -e TR_USER=username `#optional` \
  -e TR_PASSWORD=password `#optional` \
  -p 9091:9091 \
  -p 21413:51413 \
  -p 21413:51413/udp \
  -v /Users/tzp/Downloads/config:/transmission/config \
  --restart unless-stopped \
  baozaodetudou/transmission:latest

```


**docker cli**

```shell
docker run -d \
    --name tr \
    --hostname tr \
    -e UID=0     `# 想切换为哪个用户来运行程序
    -e GID=0     `# 想切换为哪个用户来运行程序
    -e UMASK=000  `# 掩码权限，默认000，可以考虑设置为022` \
    -e TR_USER=admin `#optional` \
    -e TR_PASSWORD=password `#optional` \
    -e TZ=Asia/Shanghai `#optional` \
    -p 9091:9091 \
    -p 51413:51413 \
    -p 51413:51413/udp \
    -v $(pwd)/config:/transmission/config  `# 冒号左边请修改为你想在主机上保存配置文件的路径` \
    baozaodetudou/transmission:latest
```

**docker-compose**

新建`docker-compose.yaml`文件如下，并以命令`docker-compose up -d`启动。

```yaml
version: "3"
services:
  tr:
    image: baozaodetudou/transmission:latest
    ports:
      - 9091:9091
      - 51413:51413
      - 51413:51413/udp
    volumes:
      - ./config:/transmission/config   # 冒号左边请修改为你想保存配置的路径
    environment: 
      - UID=0    # 想切换为哪个用户来运行程序，该用户的uid
      - GID=0    # 想切换为哪个用户来运行程序，该用户的gid
      - UMASK=000 # 掩码权限，默认000，可以考虑设置为022
      - TR_USER=admin `#optional` \
      - TR_PASSWORD=password `#optional` \
      - TZ=Asia/Shanghai `#optional` \
    restart: always
    network_mode: bridge
    hostname: tr
    container_name: tr
```