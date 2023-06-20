# blockscout
kubectl delete -f blockscout/bc_statefulsets/
kubectl delete -f blockscout/bc_deployments/
kubectl delete -f blockscout/bc_services/
kubectl delete -f blockscout/bc_configmap/
#kubectl delete -f blockscout/bc_namespace/

# kubectl delete -f blockscout/bc_statefulsets/blockscout-statefulset.yaml
# kubectl delete -f blockscout/bc_deployments/2.smart-contract-verifier-deployment.yaml
# kubectl delete -f blockscout/bc_deployments/3.visualizer-deployment.yaml
# kubectl delete -f blockscout/bc_deployments/1.db-postgre-deployment.yaml

# besu
kubectl delete -f statefulsets/
kubectl delete -f deployments/
#kubectl delete -f not_yet/
kubectl delete -f secrets/
kubectl delete -f configmap/
kubectl delete -f services/
#kubectl delete -f namespace/
