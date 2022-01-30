1.Install K3s cluster

```bash
export INSTALL_K3S_VERSION=v1.23.1+k3s2 
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --write-kubeconfig ~/.kube/config
```{{execute}}

2.Install Helm

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
chmod 700 get_helm.sh && \
 ./get_helm.sh && helm version
```{{execute}}

3.Install Prometheus

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# install prometheus with some components disabled
# set scrape interval to 10s
helm install prometheus prometheus-community/prometheus -n default --set alertmanager.enabled=false,pushgateway.enabled=false,nodeExporter.enabled=false,kubeStateMetrics.enabled=false,server.global.scrape_interval=10s
```{{execute}}
