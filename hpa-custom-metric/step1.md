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

3.Install kubecolor
```bash
wget https://github.com/hidetatz/kubecolor/releases/download/v0.0.20/kubecolor_0.0.20_Linux_x86_64.tar.gz && \
tar zvxf kubecolor_0.0.20_Linux_x86_64.tar.gz && \
cp kubecolor /usr/local/bin/ && \
kubecolor version
```{{execute}}

`kubecolor get pod -A`{{execute}}

4.Install Prometheus
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

`kubecolor get po  -A |grep --color=always prometheus`{{execute}}

`kubectl port-forward --address 0.0.0.0 svc/prometheus-server 9090:80`{{execute}}
Access port 9090 of the node in your browser: https://[[HOST_SUBDOMAIN]]-9090-[[KATACODA_HOST]].environments.katacoda.com/

5.Deploy httpserver
```bash
git clone https://github.com/hbstarjason2021/hpa-on-prometheus && cd hpa-on-prometheus

kubectl apply -f kubernetes/sample-httpserver-deployment.yaml
```{{execute}}

`kubecolor get po  -A  |grep --color=always httpserver`{{execute}}

6.Install Prometheus Adapter
```bash
helm install prometheus-adapter \
prometheus-community/prometheus-adapter -n default -f kubernetes/values-adapter.yaml
```{{execute}}

`kubecolor get po -A |grep adapter`{{execute}}

```bash
kubectl get --raw \
'/apis/custom.metrics.k8s.io/v1beta1/namespaces/default/pods/*/http_requests_qps' | jq .
```{{execute}}

7.Config HPA
```bash
##
kubectl apply -f kubernetes/sample-httpserver-hpa.yaml
```{{execute}}

`kubecolor get hpa`{{execute}}

8.Install vegeta
```bash
## https://github.com/tsenart/vegeta
wget https://github.com/tsenart/vegeta/releases/download/v12.8.4/vegeta_12.8.4_linux_amd64.tar.gz && \
tar zxvf vegeta_12.8.4_linux_amd64.tar.gz && \
cp vegeta /usr/bin/ && \
vegeta -version
```{{execute}}

9.Expose httpserver

`kubecolor get svc`{{execute}}

```bash
kubectl expose deploy sample-httpserver --name sample-httpserver-host --type NodePort --target-port 3000
```{{execute}}

`kubecolor  get svc sample-httpserver-host`{{execute}}

```bash
LOCAL_IP=$(ifconfig ens3 |grep "inet "| awk '{print $2}')
echo "$LOCAL_IP"
```{{execute}}

```bash
export PORT=$(kubectl get svc sample-httpserver-host -o go-template='{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}')
echo "Accessing host01:$PORT"
curl http://host01:$PORT
```{{execute}}

10.
```bash
echo "GET http://host01:$PORT" | vegeta attack -duration 60s -connections 10 -rate 240 | vegeta report
```{{execute}}

```bash
echo "GET http://host01:$PORT" | vegeta attack -duration 60s -connections 10 -rate 120 | vegeta report
```{{execute}}

```bash
echo "GET http://host01:$PORT" | vegeta attack -duration 60s -connections 10 -rate 40 | vegeta report
```{{execute}}

```bash
kubecolor describe hpa sample-httpserver
```{{execute}}

```bash
kubecolor describe deploy sample-httpserver
```{{execute}}
