# Dockerfile For Building Evernote Monitor Container
FROM geoffh1977/alpine:3
LABEL maintainer="geoffh1977 <geoffh1977@gmail.com>"
USER root

# Install Software And Build Directories
# hadolint ignore=DL3013,DL3018
RUN echo "http://dl-3.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories && \
    apk add -U --no-cache heirloom-mailx nss-tools bash && \
    mkdir -p /opt/evernote/certs /data && \
    chmod 0777 /data && \
    modutil -create -force -dbdir /opt/evernote/certs

# Add Monitor And Run Scripts
COPY scripts/evernote_monitor.sh /opt/evernote/evernote_monitor.sh
COPY scripts/evernote.sh /opt/evernote/evernote.sh
COPY scripts/start.sh /usr/local/bin/start.sh

RUN chmod 0755 /opt/evernote/evernote_monitor.sh /opt/evernote/evernote.sh /usr/local/bin/start.sh

# Set Run Options
USER ${ALPINE_USER}
WORKDIR /opt/evernote
VOLUME [ "/data" ]
CMD ["/usr/local/bin/start.sh"]
