CLUSTER_NAME=observability-cluster
CLUSTER_EXISTS = $(shell kind get clusters -q | grep $(CLUSTER_NAME))
export KIND_CONFIG_FILE_NAME=kind.config.yaml

COLOR_RESET = \033[0m
COLOR_GREEN = \033[32m
COLOR_YELLOW = \033[33m
COLOR_BLUE = \033[34m


# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help grafana create-cluster delete-cluster

help: ## Help command
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

create-cluster: ## Create cluster k8s with cert-manager e metrics-server
    ifneq ($(CLUSTER_EXISTS), $(CLUSTER_NAME))
		kind create cluster --config config/kind-cluster-config.yaml --name $(CLUSTER_NAME) --wait 10s
    else
		kubectl config use-context kind-$(CLUSTER_NAME)
		kubectl cluster-info --context kind-$(CLUSTER_NAME)
    endif
    
	@echo "#### Installing metrics-server ####"
	helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
	helm upgrade --install -n kube-system metrics-server metrics-server/metrics-server --set image.repository=bitnami/metrics-server --set image.tag=latest
	@echo

	@echo "#### Installing CertManager ####"
	kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.15.3/cert-manager.yaml
	@echo

	@echo "#### Get pods ####"
	kubectl get pods -n kube-system
	@echo

grafana-stack: ## Deploy Stack Grafana [Grafana Web, Tempo, Loki and Prometheus]
	@echo "#### Deploy Grafana-Web ####"
	helm repo add grafana https://grafana.github.io/helm-charts --namespace monitoring
	helm upgrade --install --wait --create-namespace --namespace monitoring grafana grafana/grafana -f grafana/grafana.yaml
	kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=grafana -n monitoring --timeout=30s
	@echo ""

	@echo "#### Deploy Grafana Tempo ####"
	helm upgrade --install --wait --create-namespace --namespace monitoring tempo grafana/tempo -f grafana/tempo.yaml
	kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=tempo -n monitoring --timeout=30s
	@echo ""

	@echo "#### Deploy Prometheus ####"
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm upgrade --install --wait --create-namespace --namespace monitoring prometheus prometheus-community/prometheus -f grafana/prometheus.yaml
	kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=prometheus -n monitoring --timeout=30s
	@echo ""

	@echo "#### Deploy Grafana Loki ####"
	helm upgrade --install --namespace monitoring loki grafana/loki -f grafana/loki.yaml
	@echo ""

	@echo "$(COLOR_GREEN)####################################################################$(COLOR_RESET)"
	@echo "$(COLOR_GREEN)####                                                            ####$(COLOR_RESET)"
	@echo "$(COLOR_GREEN)#### $(COLOR_YELLOW)Grafana access, run command: \"make grafana-port-forward\"$(COLOR_GREEN)   ####$(COLOR_RESET)"
	@echo "$(COLOR_GREEN)####                 $(COLOR_BLUE)http://localhost:8080$(COLOR_GREEN)                      ####$(COLOR_RESET)"
	@echo "$(COLOR_GREEN)####            Username: $(COLOR_BLUE)admin$(COLOR_GREEN) Password: $(COLOR_BLUE)admin$(COLOR_GREEN)                 ####$(COLOR_RESET)"
	@echo "$(COLOR_GREEN)####################################################################$(COLOR_RESET)"


grafana-port-forward: ## Port forward Grafana-Web
	@echo "#### Port forward Grafana-Web ####"
	kubectl -n monitoring port-forward svc/grafana 8080:80

delete-cluster: ## Delete cluster k8s
	@echo "#### Deleting cluster ####"
	kind delete cluster --name ${CLUSTER_NAME}
	podman system prune