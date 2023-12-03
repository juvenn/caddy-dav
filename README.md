`caddy-dav` - Pre-built image for caddy bundled with webdav
===

![Docker Image](https://img.shields.io/docker/v/juvenn/caddy-dav?style=flat-square)
![Docker Image Size ](https://img.shields.io/docker/image-size/juvenn/caddy-dav/2.7.4?style=flat-square)
![Docker Pulls](https://img.shields.io/docker/pulls/juvenn/caddy-dave?style=flat-square)

[Caddy](https://github.com/caddyserver/caddy) supports webdav very well with plugin [webdav](https://github.com/mholt/caddy-webdav), although it is not bundled by default. To facilitate deploying webdav on small devices, this image is built with webdav plugin.

Usage
---

To provision a webdav site in caddy, put the following in your `Caddyfile`:

```
{
  order webdav before file_server
}

media.local:8080 {
  root * /var/media
  webdav
}
```

As webdav server, it works well now. But if you'd like to view it in browser, it displays xml, which is not friendly. To make it listing directory, we need to add `file_server browse` directive:

```
{
  order webdav before file_server
}

media.local:8080 {
  @get method GET
  root * /var/media
  route {
    file_server @get browse
    webdav
  }
}
```

> [!NOTE]
> It will expose files listing in public, you may want to enable basic auth as well as tls before deploying it.

For more information, please refer to [caddy-webdav](https://github.com/mholt/caddy-webdav)

Disclaimer
---

This is just a re-packaging of caddy, all credits should to [@mholt](https://github.com/mholt/caddy-webdav) and [@caddyserver](https://github.com/caddyserver/caddy) team.
