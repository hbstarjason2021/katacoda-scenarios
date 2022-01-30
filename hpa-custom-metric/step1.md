1.Install k3s Cluster `export INSTALL_K3S_VERSION=v1.23.1+k3s2  curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --write-kubeconfig ~/.kube/config`{{execute}} .



2.Check if the available resources meet the minimal prerequisite in your cluster.
`kubectl describe nodes/node01 | grep --color=always  "memory:" | tail -1 `{{execute}}
