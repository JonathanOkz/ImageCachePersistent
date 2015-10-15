# ImageCachePersistent
iOS library for quickly storing and displaying variables images sizes

### Explanation
I'm storing with unique key, images in hard disk without blocking the main thread. For more efficiency I'm using NSCache for temporarily storing images in the RAM memory. So I can access and display images very quickly. The cache automatically purge images if the RAM is full. So the application is always fast and responsive. If an image is not yet in de cache memory, I get it in the hard disk and I set it in the cache memory, to be able to redisplay it later very quickly.
