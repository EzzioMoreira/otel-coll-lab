# 📊 Grafana Stack Deployment

This directory contains the Helm chart `values.yaml` files for deploying the Grafana stack, which includes:

- **Grafana Web**: The main UI for visualizing telemetry data (traces, logs, and metrics).
- **Grafana Tempo**: Distributed tracing backend for managing and viewing traces.
- **Grafana Loki**: Log aggregation system for managing logs.
- **Prometheus**: Metrics collection and monitoring system.

```mermaid
graph TD
    subgraph Grafana Stack
        A[Grafana Web] --> B[Grafana Tempo (Traces)]
        A --> C[Grafana Loki (Logs)]
        A --> D[Prometheus (Metrics)]
    end
    
    E[Applications] -->|Traces| B
    E -->|Logs| C
    E -->|Metrics| D
    
    B -->|Visualizes| A
    C -->|Visualizes| A
    D -->|Visualizes| A
```

## 🚀 Deployment Steps

1. **Deploy**:

    You can use `Makefile`.

    ```bash
    make grafana-stack
    ```

2. **Access Grafana Web**:

    To access the Grafana Web UI, use the following command to port-forward Grafana:

    ```bash
    make grafana-port-forward
    ```

    Then, open your browser and go to: [http://localhost:8080](http://localhost:8080)  
    Default credentials:
    - **Username**: `admin`
    - **Password**: `admin`
