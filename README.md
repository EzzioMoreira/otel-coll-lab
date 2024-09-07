# OpenTelemetry Collector - Labs 🚀

This project provides a lab environment for exploring the OpenTelemetry Collector using Kubernetes.

## Requirements 🛠️

Make sure you have the following tools installed:

- [Docker](https://docs.docker.com/get-docker/) 🐳 or [Podman](https://podman.io/) 📦
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) ☸️
- [Helm](https://helm.sh/docs/intro/install/) ⛵
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/) 📦

## Available Commands 📝

To see the list of available commands, run the following command:

```bash
make help
```

Make help Output 📋

```bash
help                 "Help"
create-cluster       "Create a Kubernetes kind cluster"
delete-cluster       "Delete the Kubernetes cluster"
```

## Create a Kind Cluster 🏗️

To create a local Kubernetes cluster, run:

```bash
Copiar código
make create-cluster
```

> This will set up a Kubernetes environment using Kind, preconfigured with cert-manager for certificates and metrics-server for monitoring.

## Delete the Cluster 🗑️

If you want to remove the cluster, use the following command:

```bash
Copiar código
make delete-cluster
```

> This will delete the local Kubernetes cluster.

## Contribute 💡
 
Feel free to contribute or open an issue if you encounter any problems! 

Let me know if you need further tweaks!
# otel-coll-lab
