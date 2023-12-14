#!bin/bash

#kubectl apply -f rocky9-statefulset.yaml

kubectl delete -f rocky8-statefulset.yaml

kubectl delete -f nexus3-statefulset.yaml

kubectl delete -f nexus-service.yaml
