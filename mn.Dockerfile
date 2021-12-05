ARG MININET_IMAGE=ghcr.io/scc365/mininet:latest
FROM ${MININET_IMAGE}

COPY entrypoint-mn.sh /
RUN chmod +x entrypoint-mn.sh

ENTRYPOINT [ "bash", "/entrypoint-mn.sh" ]
