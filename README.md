# kickstart - Autoprovisioning Microservice Container

| Flavor  | Software                                    | Support                      |    |
|---------|---------------------------------------------|------------------------------|----|
| <base>  | <base container>                            |                              | [![Docker Pulls](https://img.shields.io/docker/pulls/continue/kickstart.svg)](https://hub.docker.com/r/continue/kickstart/) [![Docker layers](https://images.microbadger.com/badges/image/continue/kickstart.svg)](https://microbadger.com/images/continue/kickstart) |
| gaia    | apache2, php7.0, imagemagick, xsl           | [details](.flavors/gaia/)    | [![Docker Pulls](https://img.shields.io/docker/pulls/continue/kickstart:gaia.svg)](https://hub.docker.com/r/continue/kickstart/) [![Docker layers](https://images.microbadger.com/badges/image/continue/kickstart:gaia.svg)](https://microbadger.com/images/continue/kickstart:gaia) |
| erebos  | nodejs, angular-cli (5)                     | [details](.flavors/erebos/)  | [![Docker Pulls](https://img.shields.io/docker/pulls/continue/kickstart:erebos.svg)](https://hub.docker.com/r/continue/kickstart/) [![Docker layers](https://images.microbadger.com/badges/image/continue/kickstart:erebos.svg)](https://microbadger.com/images/continue/kickstart:erebos) |

## Quickstart with Kickstart

Download [kickstart.sh](https://raw.githubusercontent.com/c7lab/kickstart/master/opt/kickstart.sh) and save
it to your projects main directory.

Create a `.kick.yml` with at least:

```
version: 1
from: continue/kickstart
```

Run `./kickstart.sh` - the container should start.

To select a special flavor select

```
version: 1
from: continue/kickstart-flavor:gaia
```


## Provides an standarized environment for php microservices

- Fixed Host/Path-URL: https://<branch>.<service-name>.<namespace>.sf.com
- Configuration switch for Development
- Mail-Connection (Postfix)
- MongoDb Server (stateful)

Plus:

- Checkout from git-Repository
- healthcheck

Plus:

- Preconfigured apache2.4 environment for both safety and performance

Plus:

- Private/Public-Key exchange for authentication against other
  services.


## Development and Deploy Tool: `kick`

- Will work from any directory
- All paths relative to .kickstart.yml
- Exec by default: `kick init`



## Development mode

Der Container kann genutzt werden, um apps lokal zu entwickeln. Dafür
einfach von Hand oder per Script starten:

```

```



## Config-Management

Unter `/etc/config.php` liegt die Config-Datei mit Environment:

```
define("DEBUG", true|false);
```



## Apache Location auf Service umleiten


```
<Location "/some-path/">
    ProxyPass "http://some-host/"
    ProxyPreserveHost Off
</Location>
```

## Naming of flavors

Flavor names derive from greek mystical names [click](https://de.wikipedia.org/wiki/Griechische_Mythologie)