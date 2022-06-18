
`kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml`{{execute}}    

`kubectl api-resources --api-group=tekton.dev`{{execute}}     
  
`kubectl get po -n tekton-pipelines`{{execute}}      

`minikube addons list`{{execute}} 
