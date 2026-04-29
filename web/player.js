(function () {
  const video = document.getElementById('video');
  const src = window.VIDEO_SRC;

  if (!src) {
    console.error('VIDEO_SRC 未配置');
    return;
  }

  if (video.canPlayType('application/vnd.apple.mpegurl')) {
    video.src = src;
    return;
  }

  if (window.Hls && window.Hls.isSupported()) {
    const hls = new window.Hls();
    hls.loadSource(src);
    hls.attachMedia(video);
    return;
  }

  console.error('当前浏览器不支持 HLS 播放');
})();
