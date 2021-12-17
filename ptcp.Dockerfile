ARG OPENFLOW_IMAGE=ghcr.io/scc365/mnof:latest
FROM ${OPENFLOW_IMAGE} as openflow

FROM debian:stretch-slim

COPY --from=openflow /usr/local/bin/ /usr/local/bin/

COPY ./entrypoint-ptcp.sh .
RUN chmod +x entrypoint-ptcp.sh

EXPOSE 6633
ENTRYPOINT [ "bash", "entrypoint-ptcp.sh" ]
