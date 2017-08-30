const version = 'Alpha';

const fetchAndUpdateCache = request => fetch(request)
  .then((response) => {
    if (response) {
      return caches.open(version)
        .then(cache => cache.put(request, response.clone())
          .then(() => response),
        );
    }
    return console.error('No response');
  });

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(version)
      .then(cache => cache.addAll([
        './index.html',
        './arklay.css',
        './arklay.js',
      ]),
      ),
  );
});

self.addEventListener('activate', (event) => {
  // Delete any cached assets that don't match the current version
  event.waitUntil(
    caches.keys()
      .then(keys => Promise.all(
        keys.filter(x => x !== version)
          .map(y => caches.delete(y)),
      ),
      ),
  );
});

self.addEventListener('fetch',
  (event) => {
    // on 'fetch', check cache for matching asset, 
    // else if offline return default cached index, 
    // else pass through to fetchAndUpdate
    event.respondWith(
      caches.match(event.request)
        .then((res) => {
          if (res) return res;
          if (!navigator.onLine) return caches.match(event.request);
          return fetchAndUpdateCache(event.request);
        }),
    );
  },
);
