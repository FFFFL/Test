# 山河岁月视频站（快速体验）

你可以用下面 **4 步** 在本机直接跑起来。

## 0. 环境准备

- Linux / macOS（Windows 建议 WSL）
- 已安装：`ffmpeg`、`docker`、`docker compose`、`python3`

## 1. 准备一个 MP4 并转成 HLS

把视频放到任意位置，例如：`/tmp/demo.mp4`，执行：

```bash
./scripts/transcode_to_hls.sh /tmp/demo.mp4 ./video/hls/demo
```

执行后会生成：

- `./video/hls/demo/index.m3u8`
- `./video/hls/demo/seg_00001.ts ...`

## 2. 启动视频服务（Nginx）

```bash
docker compose up -d
```

检查是否可访问：

```bash
curl -I http://localhost:8080/hls/demo/index.m3u8
```

如果返回 `HTTP/1.1 200 OK`，说明视频流服务正常。

## 3. 启动前端页面

```bash
python3 -m http.server 5500 -d web
```

浏览器打开：

- `http://localhost:5500`

这时就能在线播放，并看到右上角水印：**山河岁月**。

## 4. 停止服务

```bash
docker compose down
```

---

## 常见问题

### 1) 页面打开了但视频不播放

- 先访问 `http://localhost:8080/hls/demo/index.m3u8` 看是否能下载播放列表。
- 检查 `web/config.js` 是否是：

```js
window.VIDEO_SRC = 'http://localhost:8080/hls/demo/index.m3u8';
```

### 2) 转码很慢

- 1-2G 视频转码正常会花时间。
- 可先用更小测试视频验证流程，正式再转完整视频。

### 3) 想部署到 GitHub Pages

- 把 `web/` 目录发布到 GitHub Pages。
- 把 `web/config.js` 改成你的 Linux 服务器域名：

```js
window.VIDEO_SRC = 'https://your-domain.com/hls/demo/index.m3u8';
```
