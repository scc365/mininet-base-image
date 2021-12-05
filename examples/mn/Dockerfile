FROM ghcr.io/scc365/mn:latest

WORKDIR /topology
COPY topology.py .

CMD [ "--switch ovsk --mac --custom /topology/topology.py --topo exampleTopo" ]
