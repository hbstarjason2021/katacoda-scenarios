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


2.Install RabbitMQ   
`sudo apt-get install erlang-nox -y`{{execute}}
`sudo apt-get update -y`{{execute}}
`sudo apt-get install rabbitmq-server -y`{{execute}}
`sudo rabbitmq-plugins enable rabbitmq_management`{{execute}}

`sudo ufw allow proto tcp from any to any port 5672,15672`{{execute}}
`sudo rabbitmqctl status | grep RabbitMQ`{{execute}}

3.Config RabbitMQ
```bash
rabbitmqadmin --host 127.0.0.1 -u guest -p guest \
    declare user name=demo password=demo tags=administrator
```{{execute}}

```bash
rabbitmqadmin --host 127.0.0.1 -u guest -p guest \
    declare permission vhost=/ user=demo configure=".*" write=".*" read=".*"
```{{execute}}

```bash
rabbitmqadmin --host 127.0.0.1 -u guest -p guest \
    declare queue name=demo_queue
```{{execute}}
4.
```bash
LOCAL_IP=$(ifconfig ens3 |grep "inet "| awk '{print $2}')
echo "$LOCAL_IP"
```{{execute}}

```bash
MQ_SECRET=$(echo -n amqp://demo:demo@$LOCAL_IP:5672/ | base64)
echo "$MQ_SECRET"
```{{execute}}

```bash
kubectl create ns nginx-demo
kubectl apply -n nginx-demo -f \
   https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/controllers/nginx-deployment.yaml
```{{execute}}

```bash
cat <<EOF | kubectl apply -n nginx-demo -f -
---
apiVersion: v1
kind: Secret
metadata:
  name: keda-rabbitmq-secret
data:
  host: $MQ_SECRET    # echo -n amqp://demo:demo@$LOCAL_IP:5672/ | base64
---
apiVersion: keda.sh/v1alpha1
kind: TriggerAuthentication
metadata:
  name: keda-trigger-auth-rabbitmq-conn
spec:
  secretTargetRef:
    - parameter: host
      name: keda-rabbitmq-secret # Name of our secret
      key: host
---
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: rabbitmq-scaledobject
spec:
  scaleTargetRef:
    name: nginx-deployment # Name of our nginx-deployment that we want tot scale
  minReplicaCount: 1       # We don't want to have less than 1 replica
  maxReplicaCount: 5       # Also we don't want to have more than 5 replicas
  pollingInterval: 10      # How frequently we should go for metric (in seconds)
  cooldownPeriod:  120     # How many seconds should we wait for downscale
  triggers:
  - type: rabbitmq
    metadata:
      protocol: amqp
      queueName: demo_queue # Our demo queue
      mode: QueueLength
      value: "3" # If we've got 3 new messages in queue — adding a new pod
    authenticationRef:
      name: keda-trigger-auth-rabbitmq-conn
EOF
```{{execute}}

`kubecolor get scaledobject`{{execute}}   
`kubecolor get pod`{{execute}}   
`kubecolor get hpa`{{execute}}   

5.Testing
```bash
for i in {1..5}; do
    rabbitmqadmin --host $LOCAL_IP -u demo -p demo \
        publish exchange=amq.default routing_key=demo_queue payload="message ${i}"
done
```{{execute}}

`rabbitmqadmin -H $LOCAL_IP -u demo -p demo list queues`{{execute}}

`kubecolor get scaledobject`{{execute}}   
`kubecolor get pod`{{execute}}   
`kubecolor get hpa`{{execute}}  


