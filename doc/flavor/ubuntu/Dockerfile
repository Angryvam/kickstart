FROM ubuntu:16.04
LABEL maintainer="Matthias Leuffen <leuffen@continue.de>"

# For development-purpose only: Don't use github.com to load kickstart base package
# Comment out to test production mode.
#ADD /kickstart/ /kickstart/


ADD / /root/flavor/
RUN /root/flavor/installer-debian.sh

ENV TIMEZONE Europe/Berlin
ENV KICKSTART_HYPERVISE_HOST="http://kickstart-hypervise/"
ENV DEV_CONTAINER_NAME "unnamed"
ENV DEV_UID "1000"
ENV DEV_TTYID "xXx"

ENTRYPOINT ["/kickstart/container/start.sh"]
