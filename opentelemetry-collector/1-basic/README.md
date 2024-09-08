# OpenTelemetry Collector - Basic Config 🚀 

This setup deploys a basic OpenTelemetry Collector in a Kubernetes cluster using the configuration provided in [collector-config](configmap.yaml).

## Components 🧩 

- **Receivers**: OTLP with protocol gRPC and HTTP
- **Processors**: Batch
- **Exporters**: OTLP to `otelcol:4317`
- **Extensions**: Health check, PProf, ZPages

## How to Deploy 📦

1. Create the `opentelemetry` namespace if not already created:

```bash
kubectl create namespace opentelemetry
```

2. Apply the ConfigMap, Deployment, and Service:

```bash
kubectl apply -f configmap.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

You can verify if the OpenTelemetry Collector is running:

```bash
kubectl get pods -n opentelemetry
```

## Port-forward to access the Collector 🚪

```bash
kubectl port-forward svc/otel-collector 55680:55680 -n opentelemetry
```
