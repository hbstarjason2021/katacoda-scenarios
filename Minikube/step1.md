
`curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && \
chmod +x minikube && \
sudo mkdir -p /usr/local/bin/  && \
sudo install minikube /usr/local/bin/`{{execute}} 

`minikube version`{{execute}}    

`minikube start --kubernetes-version=v1.23.3`{{execute}}      

`kubectl cluster-info`{{execute}}       

`kubectl get nodes`{{execute}}     

`kubectl get pod -A`{{execute}}     

`kubectl run first-deployment --image=katacoda/docker-http-server --port=80`{{execute}}       

`kubectl get pod`{{execute}}        

`kubectl expose deployment first-deployment --port=80 --type=NodePort`{{execute}}    

`export PORT=$(kubectl get svc first-deployment -o go-template='{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}')`{{execute}}     

`echo "Accessing host01:$PORT"`{{execute}}     

`curl host01:$PORT`{{execute}}      

`minikube addons list`{{execute}}      

`minikube addons enable ingress`{{execute}}       

`minikube addons enable metrics-server`{{execute}}    

`minikube addons list`{{execute}}    

