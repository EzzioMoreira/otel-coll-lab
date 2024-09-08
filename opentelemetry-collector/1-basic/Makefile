# Variables
NAMESPACE=opentelemetry
COLLECTOR_CONFIG=configmap.yaml
DEPLOYMENT_FILE=deployment.yaml
SERVICE_FILE=service.yaml

.PHONY: help
help: ## Show help message
	@echo "Usage: make [command]"
	@echo
	@echo "Commands:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: create-namespace
create-namespace: ## Create the monitoring namespace
	@echo "🚀 Creating namespace: $(NAMESPACE)"
	kubectl create namespace $(NAMESPACE)

.PHONY: apply-config
apply-config: ## Apply OpenTelemetry Collector config, deployment, and service
	@echo "📦 Applying OpenTelemetry Collector configuration..."
	kubectl apply -f $(COLLECTOR_CONFIG) -n $(NAMESPACE)
	kubectl apply -f $(DEPLOYMENT_FILE) -n $(NAMESPACE)
	kubectl apply -f $(SERVICE_FILE) -n $(NAMESPACE)

.PHONY: status
status: ## Get the status of the deployed OpenTelemetry Collector pods
	@echo "🔍 Checking status of OpenTelemetry Collector pods..."
	kubectl get pods -n $(NAMESPACE) -l app=otel-coll-basic

.PHONY: logs
logs: ## Get the logs of the deployed OpenTelemetry Collector pods
	@echo "📜 Getting logs of OpenTelemetry Collector pods..."
	kubectl logs -f -n $(NAMESPACE) -l app=otel-coll-basic

.PHONY: port-forward
port-forward: ## Port forward the OpenTelemetry Collector service
	@echo "🚪 Port forwarding OpenTelemetry Collector service..."
	@echo ""
	@echo "\033[33m🔗 http://localhost:55679/debug/tracez\033[0m"
	@echo ""
	kubectl port-forward svc/otel-coll-basic 4318:4318 -n $(NAMESPACE)

.PHONY: delete
delete: ## Delete the OpenTelemetry Collector deployment and service
	@echo "🗑️ Deleting OpenTelemetry Collector resources..."
	kubectl delete -f $(COLLECTOR_CONFIG) -n $(NAMESPACE)
	kubectl delete -f $(DEPLOYMENT_FILE) -n $(NAMESPACE)
