kubectl apply -f namespace/
kubectl apply -f secrets/
kubectl apply -f configmap/
kubectl apply -f services/
kubectl apply -f not_yet/
kubectl apply -f deployments/
kubectl apply -f statefulsets/

# kubectl apply -f blockscout/smart-contract-verifier-deployment.yaml
# kubectl apply -f blockscout/visualizer-deployment.yaml
# kubectl apply -f blockscout/sig-provider-deployment.yaml
# waiting ... 
# kubectl apply -f blockscout/blockscout-deployment.yaml

# kubectl delete -f blockscout/blockscout-deployment.yaml
# kubectl delete -f blockscout/smart-contract-verifier-deployment.yaml
# kubectl delete -f blockscout/visualizer-deployment.yaml
# kubectl delete -f blockscout/sig-provider-deployment.yaml