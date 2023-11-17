#!bin/bash

kubectl apply -f nexus-service.yaml

kubectl apply -f nexus3-statefulset.yaml

kubectl apply -f rocky8-statefulset.yaml
# kubectl apply -f rocky9-statefulset.yaml

# sleep 10

# kubectl exec -it member1-0 -n besu -- bash

# kubectl delete -f rocky8-statefulset.yaml

# kubectl delete -f nexus3-statefulset.yaml

# kubectl delete -f nexus-service.yaml
