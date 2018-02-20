# Docker Skeleton Projekt

Für neue Projekte. Enthält die Docker-Basis Scripts.

## Anlegen eines neuen Projekts:

Das folgende Kommano erzeugt im aktuellen Verzeichnis ein neues Projekt

```
composer create-project -f continue/docker-skel --repository https://packages.continue.de -s dev ./
```

## Suche nach %%PROJECT_NAME%% und ersetzten!

Überall wo ein Projekt-Name eingetragen werden muss, steht per default
%%PROJECT_NAME%%. Suche und ersetzte diese durch Deinen lieblings-
Projektnamen.

## Struktur innerhalb des `.docker` Verzeichnis

### Verzeichnis `.docker/conf`

Dateien in dieser Verzeichnisstruktur ersetzten die Datein im Container


### Verzeichnis `/` wird nach `/opt` kopiert


### Verzeichnis `.templates`

Hier findest 

