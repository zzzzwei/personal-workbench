// 个人工作台 · Service Worker（让 APP 可离线、可“添加到主屏幕”）
const CACHE = 'pwb-v2';
const ASSETS = [
  './',
  './index.html',
  './manifest.webmanifest',
  './config.js',
  './icon-192.png',
  './icon-512.png'
];

self.addEventListener('install', e => {
  e.waitUntil(
    caches.open(CACHE).then(c => c.addAll(ASSETS).catch(() => {})).then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys()
      .then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

// 缓存优先，失败再走网络；网络成功时顺手更新缓存
self.addEventListener('fetch', e => {
  if (e.request.method !== 'GET') return;
  e.respondWith(
    caches.match(e.request).then(cached =>
      cached || fetch(e.request).then(resp => {
        const cp = resp.clone();
        caches.open(CACHE).then(c => c.put(e.request, cp)).catch(() => {});
        return resp;
      }).catch(() => caches.match('./index.html'))
    )
  );
});
