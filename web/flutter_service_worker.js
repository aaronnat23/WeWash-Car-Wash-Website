'use strict';

const CACHE_NAME = 'car-rental-cache-v1';
const RESOURCES = {
  "/": "index.html",
  "index.html": "index.html",
  "main.dart.js": "main.dart.js",
  "flutter.js": "flutter.js",
  "manifest.json": "manifest.json",
  "icons/Icon-192.png": "icons/Icon-192.png",
  "icons/Icon-512.png": "icons/Icon-512.png",
};

// Install event - cache resources
self.addEventListener('install', (event) => {
  console.log('Service Worker installing.');
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log('Caching app shell');
      return cache.addAll(Object.keys(RESOURCES).map(key => key));
    }).catch((error) => {
      console.log('Cache failed:', error);
    })
  );
  self.skipWaiting();
});

// Activate event - clean up old caches
self.addEventListener('activate', (event) => {
  console.log('Service Worker activating.');
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            console.log('Deleting old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  self.clients.claim();
});

// Fetch event - serve from cache, fallback to network
self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      if (response) {
        return response;
      }
      return fetch(event.request).then((response) => {
        // Cache new resources
        if (response.status === 200) {
          const responseClone = response.clone();
          caches.open(CACHE_NAME).then((cache) => {
            cache.put(event.request, responseClone);
          });
        }
        return response;
      });
    }).catch(() => {
      // Return offline page if available
      return caches.match('/index.html');
    })
  );
});
