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
help                    "Help"
create-cluster          "Create a Kubernetes kind cluster"
grafana-stack:          "Deploy Stack Grafana [Grafana Web, Tempo, Loki and Prometheus]"
grafana-port-forward:   "Port forward Grafana-Web"
delete-cluster          "Delete the Kubernetes cluster"
```

## Create a Kind Cluster 🏗️

To create a local Kubernetes cluster, run:

```bash
make create-cluster
```

> This will set up a Kubernetes environment using Kind, preconfigured with cert-manager for certificates and metrics-server for monitoring.

## Deploy Grafana Stack 📦

Deploy a Grafana stack to manage telemetry data, including trace, metrics and logs.

```bash
make grafana-stack
```

To access Grafana, run the following command:

```bash
grafana-port-forward
```

Then, open your browser and navigate to: http://localhost:8080

Use the following credentials:
- `Username: admin`
- `Password: admin`

## Delete the Cluster 🗑️

If you want to remove the cluster, use the following command:

```bash
make delete-cluster
```

> This will delete the local Kubernetes cluster.

## Contribute 💡
 
Feel free to contribute or open an issue if you encounter any problems! 

Let me know if you need further tweaks!

# Exporter Endpoints

- Grafana Tempo - Trace: tempo.monitoring.svc.cluster.local:4317
- Grafana Loki - Logs:  http://loki.monitoring.com:3100/otlp/v1/logs
- Prometheus - Metric: http://prometheus.monitoring.svc.cluster.local:9090/api/v1/write
