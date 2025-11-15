// Flutter Web Bootstrap Script
'use strict';

(function() {
  window._flutter = window._flutter || {};
  window._flutter.loader = window._flutter.loader || {};

  window._flutter.loader.loadEntrypoint = function(options) {
    options = options || {};

    // Load the service worker
    if ('serviceWorker' in navigator) {
      var serviceWorkerUrl = options.serviceWorker?.serviceWorkerUrl || 'flutter_service_worker.js';
      var serviceWorkerVersion = options.serviceWorker?.serviceWorkerVersion;

      navigator.serviceWorker.register(serviceWorkerUrl + '?v=' + serviceWorkerVersion)
        .then((registration) => console.log('Service Worker registered'))
        .catch((error) => console.log('Service Worker registration failed:', error));
    }

    // Initialize and run the app
    if (options.onEntrypointLoaded) {
      var engineInitializer = {
        initializeEngine: function() {
          return Promise.resolve({
            runApp: function() {
              console.log('Flutter app running');
              // The actual Flutter engine will be loaded by the framework
            }
          });
        }
      };
      options.onEntrypointLoaded(engineInitializer);
    }
  };
})();

// Service worker version
var serviceWorkerVersion = '1.0.0';
