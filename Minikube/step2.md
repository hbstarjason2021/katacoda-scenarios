
`kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml`{{execute}}    

`kubectl api-resources --api-group=tekton.dev`{{execute}}     
  
`kubectl get po -n tekton-pipelines`{{execute}}      

`curl -sLO https://github.com/tektoncd/cli/releases/download/v0.24.0/tkn_0.24.0_Linux_x86_64.tar.gz \
tar xvzf tkn_0.24.0_Linux_x86_64.tar.gz -C /usr/local/bin/ tkn`{{execute}}     

`tkn version`{{execute}}    

`kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.4/git-clone.yaml`{{execute}}      

`tkn hub install task git-clone`{{execute}} 
