1.Install minikube     
`curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && \
chmod +x minikube && \
sudo mkdir -p /usr/local/bin/  && \
sudo install minikube /usr/local/bin/`{{execute}} 

`minikube version`{{execute}}    

2.Install k8s      
`minikube start --cni=cilium --kubernetes-version=v1.23.3`{{execute}}      

`kubectl cluster-info`{{execute}}       

`kubectl get nodes`{{execute}}     

`kubectl get pod -A`{{execute}}      

3.Install k9s     
`wget https://github.com/derailed/k9s/releases/download/v0.25.18/k9s_Linux_x86_64.tar.gz`{{execute}}     

`tar zvxf k9s_Linux_x86_64.tar.gz`{{execute}}      

`./k9s`{{execute}}       


