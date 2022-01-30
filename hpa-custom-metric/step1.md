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
helm repo add prometheus-community \
     https://prometheus-community.github.io/helm-charts

# install prometheus with some components disabled
# set scrape interval to 10s

helm install prometheus prometheus-community/prometheus -n default \
--set alertmanager.enabled=false,\
pushgateway.enabled=false,\
nodeExporter.enabled=false,\
kubeStateMetrics.enabled=false,\
server.global.scrape_interval=10s
```{{execute}}

4.Deploy httpserver

```bash
git clone https://github.com/hbstarjason2021/hpa-on-prometheus && cd hpa-on-prometheus

kubectl apply -f kubernetes/sample-httpserver-deployment.yaml
```{{execute}}

5.Install Produmetheus Adapter

```bash
helm install prometheus-adapter prometheus-community/prometheus-adapter -n default -f kubernetes/values-adapter.yaml
```{{execute}}

6.Config HPA

```bash
##
kubectl apply -f kubernetes/sample-httpserver-hpa.yaml
```{{execute}}

7.Install vegeta

```bash
## https://github.com/tsenart/vegeta
wget https://github.com/tsenart/vegeta/releases/download/v12.8.4/vegeta_12.8.4_linux_amd64.tar.gz && \
tar zxvf vegeta_12.8.4_linux_amd64.tar.gz && \
cp vegeta /usr/bin/ && \
vegeta -version
```{{execute}}
