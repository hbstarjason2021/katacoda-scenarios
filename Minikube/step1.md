
`minikube version`{{execute}}    

`minikube start`{{execute}}      

`kubectl cluster-info`{{execute}}       

`kubectl get nodes`{{execute}}     

`kubectl get pod -A`{{execute}}     

`kubectl run first-deployment --image=katacoda/docker-http-server --port=80`{{execute}}       

`kubectl get pod`{{execute}}        

`kubectl expose deployment first-deployment --port=80 --type=NodePort`{{execute}}    

`export PORT=$(kubectl get svc first-deployment -o go-template='{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}') echo "Accessing host01:$PORT" curl host01:$PORT`{{execute}}

