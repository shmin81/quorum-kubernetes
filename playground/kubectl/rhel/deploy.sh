#!bin/bash

#kubectl apply -f nexus-service.yaml

#kubectl apply -f nexus3-statefulset.yaml

kubectl apply -f rhel8-statefulset.yaml
#kubectl apply -f rhel8minimal-statefulset.yaml

# sleep 10

# kubectl exec -it member1-0 -n besu -- bash

# kubectl delete -f rhel8-statefulset.yaml
# kubectl delete -f rhel8minimal-statefulset.yaml

# kubectl delete -f nexus3-statefulset.yaml

# kubectl delete -f nexus-service.yaml
