kubectl apply -f namespace/
kubectl apply -f blockscout_configmap/
kubectl apply -f blockscout_services/
# kubectl apply -f blockscout_deployments/
# kubectl apply -f blockscout_statefulsets/

kubectl apply -f blockscout_deployments/1.db-postgre-deployment.yaml
# kubectl apply -f blockscout_deployments/2.smart-contract-verifier-deployment.yaml
# kubectl apply -f blockscout_deployments/3.visualizer-deployment.yaml
# kubectl apply -f blockscout_deployments/4.sig-provider-deployment.yaml
# waiting ... 
sleep 15
kubectl apply -f blockscout_statefulsets/blockscout-statefulset.yaml
sleep 10
kubectl logs blockscout-0 -n blockscout -f
