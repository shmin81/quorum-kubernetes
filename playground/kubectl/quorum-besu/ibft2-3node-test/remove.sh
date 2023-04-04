
kubectl delete -f blockscout_statefulsets/
kubectl delete -f blockscout_deployments/
kubectl delete -f blockscout_services/
kubectl delete -f blockscout_configmap/

kubectl delete -f statefulsets/

kubectl delete -f deployments/
#kubectl delete -f not_yet/
kubectl delete -f secrets/
kubectl delete -f configmap/
kubectl delete -f services/
kubectl delete -f namespace/
