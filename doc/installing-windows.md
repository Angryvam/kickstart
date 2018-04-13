# Windows 10 Pro / Enterprise / Server

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
sudo apt-get update
sudo apt-get install docker.io curl git
```

You should now be able to execute `docker ps` without error.

In case of trouble, see [Windows 10 pro notes](installing-windows-versions.md).



## Other Operating Systems

Please append Instructions for other distributions.