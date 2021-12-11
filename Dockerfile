ARG MNEXEC_IMAGE=ghcr.io/scc365/mnexec:latest
ARG OPENFLOW_IMAGE=ghcr.io/scc365/mnof:latest
FROM ${MNEXEC_IMAGE} as mnexec
FROM ${OPENFLOW_IMAGE} as openflow


FROM debian:stretch-slim

RUN apt-get update -q && \
  apt-get install --no-install-recommends -yq \
  arping \
  git \
  hping3 \
  iperf3 \
  iproute2 \
  iputils-ping \
  net-tools \
  openvswitch-common \
  openvswitch-switch \
  openvswitch-testcontroller \
  python3 \
  python3-bottle \
  python3-pip \
  python3-setuptools \
  telnet \
  traceroute && \
  rm -rf /var/lib/apt/lists/*

COPY --from=openflow /usr/local/bin/ /usr/local/bin/
COPY --from=mnexec /output/mnexec /usr/bin/mnexec

ARG MININET_REPO=https://github.com/mininet/mininet
ARG MININET_VERSION=master
WORKDIR /src/mininet
RUN git clone -b ${MININET_VERSION} ${MININET_REPO} .

RUN pip3 install .

WORKDIR /
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT [ "bash", "/entrypoint.sh" ]
