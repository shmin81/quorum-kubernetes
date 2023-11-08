#!bin/bash

kubectl apply -f rocky8-statefulset.yaml
# kubectl apply -f rocky9-statefulset.yaml

# sleep 10

# kubectl exec -it member1-0 -n besu -- bash

# kubectl delete -f rocky8-statefulset.yaml