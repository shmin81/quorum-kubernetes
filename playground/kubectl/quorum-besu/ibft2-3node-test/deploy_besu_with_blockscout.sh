# besu
kubectl apply -f namespace/
kubectl apply -f secrets/
kubectl apply -f configmap/
kubectl apply -f services/
#kubectl apply -f not_yet/
kubectl apply -f deployments/
kubectl apply -f statefulsets/

# blockscout
sleep 60
kubectl apply -f blockscout/bc_namespace/
kubectl apply -f blockscout/bc_configmap/
kubectl apply -f blockscout/bc_services/
kubectl apply -f blockscout/bc_deployments/
sleep 30
kubectl apply -f blockscout/bc_statefulsets/

# kubectl apply -f blockscout/bc_deployments/1.db-postgre-deployment.yaml
# kubectl apply -f blockscout/bc_deployments/2.smart-contract-verifier-deployment.yaml
# kubectl apply -f blockscout/bc_deployments/3.visualizer-deployment.yaml
# waiting ... 
# kubectl apply -f blockscout/bc_statefulsets/blockscout-statefulset.yaml


