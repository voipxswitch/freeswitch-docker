FROM debian:buster as build_freeswitch
ADD script /tmp/freeswitch
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates gnupg2 wget
RUN /usr/bin/wget -O - https://files.freeswitch.org/repo/deb/freeswitch-1.8/fsstretch-archive-keyring.asc | apt-key add -
RUN /bin/echo "deb http://files.freeswitch.org/repo/deb/freeswitch-1.8/ buster main" > /etc/apt/sources.list.d/freeswitch.list
RUN /bin/echo "deb-src http://files.freeswitch.org/repo/deb/freeswitch-1.8/ buster main" >> /etc/apt/sources.list.d/freeswitch.list
RUN apt-get update && apt-get install -y freeswitch freeswitch-mod-console freeswitch-mod-sofia freeswitch-mod-commands freeswitch-mod-conference freeswitch-mod-db freeswitch-mod-dptools freeswitch-mod-hash freeswitch-mod-dialplan-xml freeswitch-mod-sndfile freeswitch-mod-native-file freeswitch-mod-tone-stream freeswitch-mod-say-en freeswitch-mod-event-socket
RUN /bin/bash -c "source /tmp/freeswitch/make_min_archive.sh"
RUN /bin/mkdir /tmp/build_image
RUN /bin/tar zxvf ./freeswitch_img.tar.gz -C /tmp/build_image

FROM scratch
COPY --from=build_freeswitch /tmp/build_image /
ADD etc/freeswitch /etc/freeswitch
CMD ["/usr/bin/freeswitch", "-nc", "-nf", "-nonat"]
