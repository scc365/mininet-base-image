# Mininet Docker Base Image 🐳

This is a base image for a dockerizing Mininet topologies. It can be used to dockerize topologies that uses Mininet's Python API or, by using the `mn` image, topologies that are instantiated via the `mn` CLI tool.

## Available Images

All images are available via the GitHub Container Registry (`ghcr.io`) and target ARM and x86 architectures.

### Using the Python API: 
If your topology is a python script, you can use the `ghcr.io/scc365/mininet:latest` image.

Example:
```Dockerfile
FROM ghcr.io/scc365/mininet:latest

WORKDIR /topology
COPY topology.py .

CMD [ "topology.py" ]
```

### Using the `mn` CLI Tool: 
If you instantiate your topology via `mn`, you can use the `ghcr.io/scc365/mn:latest` image.

Example:
```Dockerfile
FROM ghcr.io/scc365/mn:latest

WORKDIR /topology
COPY topology.py .

CMD [ "--switch ovsk --mac --custom /topology/topology.py --topo exampleTopo" ]
```

## Updating

Think that a tool or package is so commonly used in creating topologies (or testing them) that it should be in the base image? Feel free to create a PR updating `Dockerfile`, but please write a small justification in the PR.
