FROM debian:stretch-slim as builder

RUN apt-get update -q
RUN apt-get install -yq \
  autoconf \
  automake \
  libtool \
  make \
  gcc \
  git \
  autotools-dev \
  pkg-config \
  libc6-dev

ARG MININET_REPO=https://github.com/mininet/mininet
ARG MININET_VERSION=master
WORKDIR /src/mininet
RUN git clone -b ${MININET_VERSION} ${MININET_REPO} .

ARG MININET_OF_REPO=https://github.com/mininet/openflow ./openflow
WORKDIR /src/mnof
RUN git clone ${MININET_OF_REPO}
RUN cp -R /src/mininet/util/openflow-patches/ openflow-patches/

WORKDIR /src/mnof/openflow
RUN patch -p1 < ../openflow-patches/controller.patch

RUN ./boot.sh && ./configure && make install

FROM scratch

COPY --from=builder /usr/local/bin/ /usr/local/bin/
