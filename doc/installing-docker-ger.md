# Installation von Docker und erstellen einer Debug-IP

Anleitung verfügbar für:
- Windows
  - Windows 10 Pro / Enterprise / Server
- Ubuntu/Kubuntu
    - 16.04
    - 17.10
    - 18.04


## Windows 10 Pro / Enterprise / Server

> Funktionier ***nicht*** unter ***Windows 10 Home***, da HyperV nicht richtig unterstützt wird

- Laden und installieren Sie Docker für Windows über [dockerstore](https://www.docker.com/docker-windows)
- Rechts unten in der Taskleiste Rechtklick auf das Dockerzeichen und auf ***Settings*** gehen
- aktivieren Sie ***Expose daemon on tcp://localhost:2375 without TLS***
- Suchen sie in der ***Suchleiste*** nach ***Windows-Features aktivieren oder deaktivieren*** und aktivieren Sie
***Windows-Subsystem für Linux***
- Gehen Sie zur folgender [Seite](https://aka.ms/wslstore) und laden Sie sich ***ubuntu*** runter und starten Sie dieses
- Suchen Sie nach Diensten und deaktivieren Sie  W3SVC (World Wide Web Publishing Service), falls er vorhanden ist
- Suchen Sie nach ***Windows Power Shell*** und geben Sie `netsh http add iplisten ipaddress=::` ein
- Gehen sie nun in die ***bash-Konsole*** und führen Sie folgendes aus:

```
echo "KICKSTART_WIN_PATH=C:/" >> ~/.kickstartconfig
echo "DOCKER_HOST=tcp://127.0.0.1:2375" >> ~/.kickstartconfig
echo "DOCKER_TLS_VERFIY=0" >> ~/.kickstartconfig
echo "DOCKER_CERT_PATH=0" >> ~/.kickstartconfig
sudo apt-get update
sudo apt-get install docker.io curl git
```

Nun sollten Sie `docker ps` ausführen können ohne einen Fehler zu erhalten



## Ubuntu/Kubuntu 16.04, 17.10, 18.04

Öffenen Sie ein Terminal und geben Sie folgendes ein:

```bash
sudo apt-get install docker.io curl
sudo gpasswd -a $USER docker
```

Dies installiert docker curl und fügt ihren User zur Dockergruppe hinzu.

Loggen Sie sich einmal ein und aus. Nun sollten sie `docker ps` ohne Fehler ausführen können.

***Netzwerk Setup***

Bearbeiten sie `/etc/network/interfaces` und fügen sie folgendes hinzu:

```yaml
auto eno0:10
iface eno0:10 inet static
    address 10.10.10.10
    netmask 255.255.255.255
```

(ersetzten sie `eno0` durch das richtige Interfacenamen auf ihren Desktop)

Führen Sie `sudo /etc/init.d/networking restart` auf Ihrer Konsole aus und Sie sollten `ping 10.10.10.10` ausführen können.

## Andere Betriebssysteme

Bitte fügen sie Informationen zu anderen Betriebssysteme hinzu.