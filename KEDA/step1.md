1.Install KEDA  

```bash
wget https://github.com/hidetatz/kubecolor/releases/download/v0.0.20/kubecolor_0.0.20_Linux_x86_64.tar.gz && \
tar zvxf kubecolor_0.0.20_Linux_x86_64.tar.gz && \
cp kubecolor /usr/local/bin/ && \
kubecolor version
```{{execute}}

`kubecolor get pod -A`{{execute}}

```bash
helm repo add kedacore https://kedacore.github.io/charts
helm repo update

kubectl create namespace keda
helm install keda kedacore/keda --namespace keda
```{{execute}}

`kubecolor get pods -n keda`{{execute}}

2.

3.

4.
