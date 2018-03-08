# kickstart - Autoprovisioning Microservice Container

| Flavor  | Pull-Name                          | Software                                    | Support                      |    |
|---------|------------------------------------|---------------------------------------------|------------------------------|----|
|         | `continue/kickstart`               | <base container>                            |                              | [![Docker Pulls](https://img.shields.io/docker/pulls/continue/kickstart.svg)](https://hub.docker.com/r/continue/kickstart/) [![Docker layers](https://images.microbadger.com/badges/image/continue/kickstart.svg)](https://microbadger.com/images/continue/kickstart) |
| gaia    | `continue/kickstart-flavor-gaia`   | apache2, php7.1, imagemagick, xsl, ...      | [details](https://github.com/c7lab/kickstart-flavor-gaia/blob/master/README.md)    | [![Docker Pulls](https://img.shields.io/docker/pulls/continue/kickstart-flavor-gaia.svg)](https://hub.docker.com/r/continue/kickstart-flavor-gaia/) [![Docker layers](https://images.microbadger.com/badges/image/continue/kickstart-flavor-gaia.svg)](https://microbadger.com/images/continue/kickstart-flavor-gaia) |
| erebos  | `continue/kickstart-flavor:erebos` | nodejs, angular-cli (5)                     | [details](.flavors/erebos/)  | [![Docker Pulls](https://img.shields.io/docker/pulls/continue/kickstart-flavor:erebos.svg)](https://hub.docker.com/r/continue/kickstart/) [![Docker layers](https://images.microbadger.com/badges/image/continue/kickstart-flavor:erebos.svg)](https://microbadger.com/images/continue/kickstart-flavor:erebos) |


***(do you have ready to use containers - append it to this list)***


## Quickstart with Kickstart

Download [kickstart.sh](https://raw.githubusercontent.com/c7lab/kickstart/master/opt/kickstart.sh) and save
it to your projects main directory:

```
curl -o kickstart.sh "https://raw.githubusercontent.com/c7lab/kickstart/master/opt/kickstart.sh" && chmod +x kickstart.sh
```

Run kickstart:

```
./kickstart.sh
```

It will create an empty `.kick.yml` file in the current directory. You might edit
at least the `from:`-Line.


## .kick.yml - Kickstart configuration file.

```
version: 1
from: "continue/kickstart"
```

Run `./kickstart.sh` - the container should start.

To select a special flavor select

```
version: 1
from: continue/kickstart-flavor:gaia
```


## Provides an rapid development environment for php microservices

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


## Install Docker

Install docker by running 

``
sudo apt-get install docker.io
sudo gpasswd -a $USER docker
``

and reboot your system. That's it (`docker ps` should return no error) 


## Building own flavors

Feel free to build your own flavors.

Some rules:

- Each flavor should reside in an separate repository
- It must build the tags `latest` (stable release) and `testing` (current master branch build)
- It must provide tests
- And should provide easy to use documentation
- It should build using hub.docker.com public build service (free of charge!)

Flavor names derive from greek mystical names [click](https://de.wikipedia.org/wiki/Griechische_Mythologie)