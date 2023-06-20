kubectl apply -f bc_namespace/
kubectl apply -f bc_configmap/
kubectl apply -f bc_services/
# kubectl apply -f bc_deployments/
# kubectl apply -f bc_statefulsets/

kubectl apply -f bc_deployments/1.db-postgre-deployment.yaml
# kubectl apply -f bc_deployments/2.smart-contract-verifier-deployment.yaml
# kubectl apply -f bc_deployments/3.visualizer-deployment.yaml
# waiting ... 
sleep 15
kubectl apply -f bc_statefulsets/blockscout-statefulset.yaml
sleep 10
kubectl logs blockscout-0 -n blockscout -f
