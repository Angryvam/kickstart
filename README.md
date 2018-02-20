# kickstart - Autoprovisioning Microservice Container


| Version | Software | Support |
|---------|----------|---------|
| rev1    | ubuntu16.04, Angular 5, PHP 7.2  |         |


## Quickstart with Kickstart

Download [kickstart.sh](https://raw.githubusercontent.com/c7lab/kickstart/master/opt/kickstart.sh) and save
it to your projects main directory.


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