
## Flow of the process:
- Create private/public keys for the validators & update the secrets/validator-keys-secret.yaml with the validator private keys
- Update the configmap/configmap.yml with the public keys & genesis file
- Update the number of nodes you would like in deployments/node-deployment.yaml
- Run kubectl
- Monitoring via cakeshop in a separate *monitoring* namespace and exposed via NodePort services (ports 30099)

## Overview of Setup
- genesis
  - 1초마다 블록 생성
  - 새로 생성하고 싶은 경우, playground/kubectl/quorum-go/qbft-4v-test의 READ.md 파일을 참조
- validator1을 bootnode로 설정
  - validator1에 --nodiscover 옵션 추가 (외부 다른 이더리움 네트워크와의 연결 시도를 하지 않기 위해?)
  - validator2~4에 bootnodes 설정 추가 (validator1에 연결되도록)

## NOTE:
1. There are 4 validators (1 -4)
2. If you add more validators in past the initial setup, they need to be voted in to be validators i.e they will serve as normal nodes and not validators until they've been voted in.

#### 1. nodes private keys & account keys
Create private/public keys for the validators using the geth subcommands. The private keys are put into secrets and the public keys go into a configmap to get the bootnode enode address easily
Repeat this process for as many validators as you would like to provision i.e keys and replicate the deployment & service

Node private key:
```bash
bootnode -genkey /path/to/key
```

Node account key:
```bash
echo -ne SuperSecretPassword > /path/to/password.txt
geth account new --password /path/to/password.txt
```

Update the secrets/node-keys.yaml with the keys. The private keys are put into secrets and the public keys go into a configmap that other nodes use to create the enode address
Update the configmap/configmap.yaml with the public keys
**Note:** Please remove the '0x' prefix of the public keys


#### 2. Genesis.json
Copy the genesis.json file and copy its contents into the configmap/configmap as shown

#### 3. Update any more config if required
eg: To alter the number of nodes on the network, alter the `replicas: 2` in the deployments/node-deployments.yaml to suit

```bash
# exec tptions 
validator# options: --revertreason  --verbosity 3  --syncmode full --gcmode archive (default)

# test
validator1 options: --verbosity 5  --syncmode full --gcmode archive
validator2 options: --verbosity 3  --syncmode full --gcmode archive
validator3 options: --verbosity 5  --syncmode full (default: --gcmode full)
validator4 options: --verbosity 3  --syncmode full (default: --gcmode full)
```

#### 4. Deploy:
```bash

./deploy.sh

```

#### 5. In the dashboard, you will see each bootnode deployment & service, nodes & a node service, miner if enabled, secrets(opaque) and a configmap

If using minikube
```bash
minikube dashboard &
```

#### 6. Verify that the nodes are communicating:
```bash
minikube ssh

# once in the terminal
curl -X POST --data '{"jsonrpc":"2.0","method":"net_peerCount","params":[],"id":1}' <besu_NODE_SERVICE_HOST>:8545

# which should return:
The result confirms that the node running the JSON-RPC service has two peers:
{
  "jsonrpc" : "2.0",
  "id" : 1,
  "result" : "0x5"
}

```


#### 7. Monitoring
Get the ip that minikube is running on
```bash
minikube ip
```

For example if the ip returned was `192.168.99.100`

*Cakeshop:*
In a fresh browser tab open `192.168.99.100:30099` to get to the Cakeshop dashboard and you can see all the available metrics, as well as the targets that it is collecting metrics for



#### 8. Delete
```
./remove.sh
```
