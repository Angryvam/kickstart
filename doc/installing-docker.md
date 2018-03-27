# Installing Docker and setting up Debug-IP

Instructions available for:
- Ubuntu/Kubuntu
    - 16.04
    - 17.10
    - 18.04
    

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