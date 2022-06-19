
1.Make sure your Kubernetes version is compatible by running `kubectl version`{{execute}} in your cluster node.
> Pay attention to `Server Version` line, if `GitVersion` is greater than `v1.17.0`, it's good to go

2.Check if the available resources meet the minimal prerequisite in your cluster.
`kubectl describe nodes/node01 | grep --color=always  "memory:" | tail -1 `{{execute}}   

3.Install Tekton    
`kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.26.0/release.yaml`{{execute}}   
`kubectl get pods --namespace tekton-pipelines`{{execute}}

4.Install Tekton CLI   
```bash
wget https://github.com/tektoncd/cli/releases/download/v0.23.0/tkn_0.23.0_Linux_x86_64.tar.gz
tar xf tkn_0.23.0_Linux_x86_64.tar.gz
mv tkn /usr/bin/ && \
tkn version
```{{execute}}

5.Install Tekton Dashboard
`kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml`{{execute}}    
`kubectl get pods --namespace tekton-pipelines`{{execute}}   
`kubectl get svc tekton-dashboard -n tekton-pipelines`{{execute}}    

`kubectl port-forward -n tekton-pipelines --address=0.0.0.0 service/tekton-dashboard 80:9097 > /dev/null 2>&1 &`{{execute}}   
https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/
