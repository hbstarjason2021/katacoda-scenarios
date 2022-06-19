`git clone https://github.com/hbstarjason2021/pipeline-craft && \
cd pipeline-craft/tekton && ls -l `{{execute}}      

`kubectl apply -f 01-pipelineresource.yaml`{{execute}}   

`kubectl apply -f 02-git-secret.yaml`{{execute}}  

`kubectl apply -f 03-dockerhub-secret.yaml`{{execute}}   

`kubectl apply -f 04-build-sa.yaml`{{execute}}   

1.Frist Taskrun Test   
`kubectl apply -f task-echo-hello-world.yaml`{{execute}}    

`kubectl apply -f taskrun-echo-hello-world.yaml`{{execute}}   

`kubectl get po`{{execute}}   

`tkn taskrun list`{{execute}}    

`tkn taskrun logs taskrun-echo-hello-world`{{execute}}     

2.
