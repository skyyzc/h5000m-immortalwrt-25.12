/*
 * Service worker is intentionally disabled to avoid side effects in browser windows.
 */
self.addEventListener('install', () => {
  self.skipWaiting()
})

self.addEventListener('activate', (event) => {
  event.waitUntil(
    (async () => {
      try {
        await self.registration.unregister()
      } catch (_) {
        // Ignore unregister failures.
      }
    })(),
  )
})
