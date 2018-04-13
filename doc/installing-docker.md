# Installing Docker and setting up Debug-IP

Instructions available for:
- Windows 10
    - Windows 10 Pro / Enterprise / Server
- Ubuntu/Kubuntu
    - 16.04
    - 17.10
    - 18.04
    

## Windows 10 Pro / Enterprise / Server

> This will ***not*** work for ***Windows 10 Home*** due to a lack of HyperV support

- Install Docker for windows from [dockerstore](https://www.docker.com/docker-windows)

- Search for ***Docker for Windows*** > ***Settings*** And activate ***Expose daemon on tcp://localhost:2375 without TLS***

- Go to ***Settings*** > ***Update & Security*** > ***For developers*** and activate ***Developer mode***

- Go to ***Control Panel*** > ***Programs*** and select ***Turn Windows features on or off***: 
  Select (activate) ***Windows Subsystem for Linux (Beta)*** and reboot
  
- Download and start ***ubuntu*** by following this [link](https://aka.ms/wslstore)
  
- Click to start menu and type ***bash***, accept the Terms and Conditions.

- Turn off  W3SVC (World Wide Web Publishing Service): Search for ***Services***, scroll down and deactivate this service (if it's active).

- Deactivate HTTP.SYS service on port 80 by running `netsh http add iplisten ipaddress=::` in ***Windows PowerShell***

Within bash run

```
echo "KICKSTART_WIN_PATH=C:/" >> ~/.kickstartconfig
echo "DOCKER_HOST=tcp://127.0.0.1:2375" >> ~/.kickstartconfig
echo "DOCKER_TLS_VERFIY=0" >> ~/.kickstartconfig
echo "DOCKER_CERT_PATH=0" >> ~/.kickstartconfig
sudo apt-get update
sudo apt-get install docker.io curl git
```

You should now be able to execute `docker ps` without error.


## Ubuntu/Kubuntu 16.04, 17.10, 18.04

As user run:
```bash
sudo apt-get install docker.io curl
sudo gpasswd -a $USER docker
```
This will install docker and curl and add your local user to the docker group.

Logout and login again. You should be able to run `docker ps` without warnings as
unprivileged user.

***Network Setup***

Edit `/etc/network/interfaces` and add 

```yaml
auto eno0:10
iface eno0:10 inet static
    address 10.10.10.10
    netmask 255.255.255.255
```

(replace `eno0` with the correct interface name on your desktop)

run `sudo /etc/init.d/networking restart` and you should be able to 
`ping 10.10.10.10`.

## Other Operating Systems

Please append Instructions for other distributions.