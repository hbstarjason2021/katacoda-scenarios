1.Install kubecolor  
```bash
wget https://github.com/hidetatz/kubecolor/releases/download/v0.0.20/kubecolor_0.0.20_Linux_x86_64.tar.gz && \
tar zvxf kubecolor_0.0.20_Linux_x86_64.tar.gz && \
cp kubecolor /usr/local/bin/
```{{execute}}    

`kubecolor version`{{execute}}  

`kubecolor get pod -A`{{execute}}   

`git clone https://github.com/hbstarjason2021/spinnaker-install && cd spinnaker-install`{{execute}}   

2.Deploy Halyard     
`bash install-hal.sh`{{execute}}

3.Install Minio     
`bash install-minio.sh`{{execute}}

4.Setting up the provider   
`bash setup-kubernetes-provider.sh`{{execute}}

6.Deploy Spinnaker    
`hal deploy apply`{{execute}}  

`kubecolor -n spinnaker get po`{{execute}}  

7.Deploy Ingress-nginx     
`bash install-ingress-nginx.sh`{{execute}}
