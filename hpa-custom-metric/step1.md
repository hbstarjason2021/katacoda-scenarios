1.Install k3s Cluster.
````bash
export INSTALL_K3S_VERSION=v1.23.1+k3s2  
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --write-kubeconfig ~/.kube/config
````{{execute}} 

2.Intall Helm3
````bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
chmod 700 get_helm.sh && \
 ./get_helm.sh && helm version
````{{execute}} 

3.Check if the available resources meet the minimal prerequisite in your cluster.
`kubectl describe nodes/node01 | grep --color=always  "memory:" | tail -1 `{{execute}}
