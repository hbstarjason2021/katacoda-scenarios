
1.Make sure your Kubernetes version is compatible by running `kubectl version`{{execute}} in your cluster node.
> Pay attention to `Server Version` line, if `GitVersion` is greater than `v1.17.0`, it's good to go

2.Check if the available resources meet the minimal prerequisite in your cluster.
`kubectl describe nodes/node01 | grep --color=always  "memory:" | tail -1 `{{execute}}
