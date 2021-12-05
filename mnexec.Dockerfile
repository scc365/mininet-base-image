FROM debian:stretch-slim as builder

RUN apt-get update -q
RUN apt-get install -yq gcc git

ARG MININET_REPO=https://github.com/mininet/mininet
ARG MININET_VERSION=master
WORKDIR /src
RUN git clone -b ${MININET_VERSION} ${MININET_REPO} .

ARG MNEXEC_VERSION="latest"
RUN mkdir -p /output
RUN gcc -Wall -Wextra -DVERSION=\"\(${MNEXEC_VERSION}\)\" mnexec.c -o /output/mnexec

FROM scratch

COPY --from=builder /output/mnexec /output/mnexec
