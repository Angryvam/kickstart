# kickstart - Autoprovisioning Microservice Container (Linux, Windows10, MacOS)

| Flavor  | Pull-Name                          | Software                                    | Support                      |    |
|---------|------------------------------------|---------------------------------------------|------------------------------|----|
|         | `continue/kickstart`               | <base container>                            |                              | [![Docker Pulls](https://img.shields.io/docker/pulls/continue/kickstart.svg)](https://hub.docker.com/r/continue/kickstart/) [![Docker layers](https://images.microbadger.com/badges/image/continue/kickstart.svg)](https://microbadger.com/images/continue/kickstart) |
| gaia    | `continue/kickstart-flavor-gaia`   | apache2, php7.1, imagemagick, xsl, ...      | [details](https://github.com/c7lab/kickstart-flavor-gaia/blob/master/README.md)    | [![Docker Pulls](https://img.shields.io/docker/pulls/continue/kickstart-flavor-gaia.svg)](https://hub.docker.com/r/continue/kickstart-flavor-gaia/) [![Docker layers](https://images.microbadger.com/badges/image/continue/kickstart-flavor-gaia.svg)](https://microbadger.com/images/continue/kickstart-flavor-gaia) |
| erebos  | `continue/kickstart-flavor-erebos` | nodejs, angular-cli (5)                     | [details](https://github.com/c7lab/kickstart-flavor-erebos/blob/master/README.md)  | [![Docker Pulls](https://img.shields.io/docker/pulls/continue/kickstart-flavor-erebos.svg)](https://hub.docker.com/r/continue/kickstart-flavor-erebos/) [![Docker layers](https://images.microbadger.com/badges/image/continue/kickstart-flavor-erebos.svg)](https://microbadger.com/images/continue/kickstart-flavor-erebos) |


___(do you have ready to use containers - append it to this list)___


## Documents index

- **Setting up your environment**
    - Configuring **Ubuntu/Debian Linux** 
        - [Ubuntu installation (EN)](doc/installing-ubuntu-debian.md)
    
    - Configuring **Windows 10 Pro** 
        - [Windows 10 Pro installation (EN)](doc/installing-windows.md)
        - [Windows 10 Pro installation (DE) - might be outdated](doc/installing-windows-ger.md)
        - [Windows 10 Pro Version history](doc/installing-windows-versions.md)
    


## Project setup: Kickstart

**Copy'n'Paste installer script**: (execute as user in your project-directory)
```bash
curl -o kickstart.sh "https://raw.githubusercontent.com/c7lab/kickstart/master/opt/kickstart.sh" && chmod +x kickstart.sh
```

The script will save [kickstart.sh](https://raw.githubusercontent.com/c7lab/kickstart/master/opt/kickstart.sh) to the
current directory and set the executable bit.

**Run kickstart:**
```bash
./kickstart.sh
```

Kickstart will create an empty `.kick.yml` file in the current directory. You might want to edit
at least the `from:`-Line.


## .kick.yml - Kickstart configuration file.

```yaml
version: 1
from: "continue/kickstart"
```

Run `./kickstart.sh` - the container should start.

To select a special flavor select

```yaml
version: 1
from: "continue/kickstart-flavor-gaia"
```

## Development and Deploy Tool: `kick`

- Will work from any directory
- All paths relative to .kickstart.yml
- Exec by default: `kick init`

## System-wide config file

Kickstart will read the user-config from:
```
~/.kickstartconfig
```

Available Options:

```
KICKSTART_PORT=80           # Change the Port 
KICKSTART_WIN_PATH=         # If running on windows - map bash 
```


## Defaults

### Networking

By default, kickstart will configure debuggers to send data to `10.10.10.10`. So 
this ip should be added to your pc's networks.


## Building own flavors

Feel free to build your own flavors.

Some rules:

- Each flavor should reside in an separate repository
- It must build the tags `latest` (stable release) and `testing` (current master branch build)
- It must provide tests
- And should provide easy to use documentation
- It should build using hub.docker.com public build service (free of charge!)

Flavor names derive from greek mystical names [click](https://de.wikipedia.org/wiki/Griechische_Mythologie)