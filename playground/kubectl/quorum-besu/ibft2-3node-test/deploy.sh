kubectl apply -f namespace/
kubectl apply -f secrets/
kubectl apply -f configmap/
kubectl apply -f services/
#kubectl apply -f not_yet/
kubectl apply -f deployments/
kubectl apply -f statefulsets/
sleep 60
kubectl apply -f blockscout_configmap/
kubectl apply -f blockscout_services/
kubectl apply -f blockscout_deployments/
sleep 30
kubectl apply -f blockscout_statefulsets/

# kubectl apply -f blockscout_deployments/1.db-postgre-deployment.yaml
# kubectl apply -f blockscout_deployments/2.smart-contract-verifier-deployment.yaml
# kubectl apply -f blockscout_deployments/3.visualizer-deployment.yaml
# kubectl apply -f blockscout_deployments/4.sig-provider-deployment.yaml
# waiting ... 
# kubectl apply -f blockscout_statefulsets/blockscout-statefulset.yaml

# kubectl delete -f blockscout_statefulsets/blockscout-statefulset.yaml
# kubectl delete -f blockscout_deployments/2.smart-contract-verifier-deployment.yaml
# kubectl delete -f blockscout_deployments/3.visualizer-deployment.yaml
# kubectl delete -f blockscout_deployments/4.sig-provider-deployment.yaml
# kubectl delete -f blockscout_deployments/1.db-postgre-deployment.yaml
