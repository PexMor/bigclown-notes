FROM ubuntu

LABEL maintainer="Petr Moravek" name=gccarm version=1.0

# Set correct environment variables.
ENV CONTAINER=docker \
    PXL_NAME=gccarm \
    COLUMNS=80 \
    LINES=24 \
    TERM=xterm-256color \
    DEBIAN_FRONTEND=noninteractive

ENTRYPOINT [ "/opt/bin/loopForever" ]

ADD src/ /root/src

ADD include/ /root/

RUN sh -C /root/runAll.sh 1>&2

ENV HOME /host
WORKDIR /host
USER user
