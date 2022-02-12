1.Install KEDA  

```bash
helm repo add kedacore https://kedacore.github.io/charts
helm repo update

kubectl create namespace keda
helm install keda kedacore/keda --namespace keda
```{{execute}}

`kubectl get pods -n keda`{{execute}}

2.

3.

4.
