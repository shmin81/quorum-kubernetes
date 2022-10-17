
## Flow of the process:
- Create private/public keys for the validators & update the secrets/validator-keys-secret.yaml with the validator private keys
- Update the configmap/configmap.yml with the public keys & genesis file
- Update the number of nodes you would like in deployments/node-deployment.yaml
- Run kubectl
- Monitoring via cakeshop in a separate *monitoring* namespace and exposed via NodePort services (ports 30099)

## Overview of Setup

- validator1을 bootnode로 설정
  - validator1에 --nodiscover 옵션 추가 (외부 다른 이더리움 네트워크와의 연결 시도를 하지 않기 위해?)
  - validator2~4에 bootnodes 설정 추가 (validator1에 연결되도록)
-
- [quorum-genesis-tool](https://www.npmjs.com/package/quorum-genesis-tool)을 이용한 블록체인 네트워크 및 노드 키 관련 정보 생성
  - 튜토리얼 참조: https://consensys.net/docs/goquorum/en/latest/tutorials/private-network/create-qbft-network/
```bash
# QBFT sample (for qbft-4v-test) : --accountPassword가 없을 경우, 빈 accountPassword 파일이 생성되어 관련내용의 처리가 어려웠음
$ npx quorum-genesis-tool --consensus qbft --chainID 92022 --blockperiod 2 --requestTimeout 4 --epochLength 30000 --difficulty 1 --gasLimit '0x1FFFFFFF' --coinbase '0x0000000000000000000000000000000000000000' --validators 4 --members 0 --bootnodes 0 --accountPassword 'Password' --outputPath 'artifacts'
# QBFT other sample (위 샘플에서 블록생성을 1초로 변경 및 default 값을 사용하는 값이 변경되지 않을 항목은 제외함)
$ npx quorum-genesis-tool --consensus qbft --chainID 92022 --blockperiod 1 --requestTimeout 2 --emptyBlockPeriod 1 --gasLimit '0x1FFFFFFF' --maxCodeSize 64 --txnSizeLimit 128 --validators 4 --members 0 --bootnodes 0 --accountPassword 'Password' --outputPath 'artifacts'
# IBFT other sample (ibft는 --emptyBlockPeriod 옵션을 사용할 수 없음)
$ npx quorum-genesis-tool --consensus ibft --chainID 92022 --blockperiod 1 --requestTimeout 2 --gasLimit '0x1FFFFFFF' --maxCodeSize 64 --txnSizeLimit 128 --validators 4 --members 0 --bootnodes 0 --accountPassword 'Password' --outputPath 'artifacts'
```

```bash
# help
$ npx quorum-genesis-tool --help

Options:
  --help                   Show help                                   [boolean]
  --version                Show version number                         [boolean]
  --consensus              Consensus algorithm to use  
                            [string] [required] [choices: "ibft", "ibft2", "qbft", "clique", "raft"] [default: "qbft"]
  --chainID                ChainID for blockchain                      [number] [required] [default: 1337]
  --blockperiod            Number of seconds per block                 [number] [required] [default: 5]
  --requestTimeout         Minimum request timeout for each round      [number] [default: 10]
  --emptyBlockPeriod       (QBFT only) Reduce number (seconds) of blocks produced when there are no transactions  [number] [default: 60]
  --epochLength            Number of blocks after which votes reset    [number] [required] [default: 30000]
  --difficulty             Difficulty of network                       [number] [required] [default: 1]
  --gasLimit               Block gas limit                             [string] [required] [default: "0xFFFF"]
  --coinbase               Address to pay mining rewards to            [string] [default: "0x0000000000000000000000000000000000000000"]
  --maxCodeSize            Maximum contract size (kb)                  [number] [default: 64] [up to: 128]
  --txnSizeLimit           Maximum transaction size (kb)               [number] [default: 64] [up to: 128]
  --validators             Number of validator node keys to generate   [number] [required] [default: 4]
  --members                Number of member node keys to generate      [number] [required] [default: 1]
  --bootnodes              Number of bootnode node keys to generate    [number] [required] [default: 2]
  --accountPassword        Password for keys                           [string] [default: ""]
  --outputPath             Output path relative to current directory   [string] [default: "./output"]
  --tesseraEnabled         Whether to generate tessera keys            [boolean] [default: false]
  --tesseraPassword        Set password to encrypt generated keys      [string] [default: ""]
  --quickstartDevAccounts  Include quorum-dev-quickstart test accounts [boolean] [required] [default: false]
```

- 생성 결과
  - apply to configmap and secrets 템플릿
  - statefulsets의 각 노드에 반영
    - validator2~4 템플릿 파일의 환경변수 설정의 QUORUM_NETWORK_ID 값을 반영 (QUORUM_CONSENSUS, PRIVATE_CONFIG 값도 확인)
    - validator2~4 템플릿 파일의 bootnodes 정보를 업데이트 (아래 validator0의 nodekey.pub 파일 정보를 참조하여...)
```bash
playground/kubectl/quorum-go/qbft-4v-test
├── artifacts
    └──2022-10-15-13-34-10
        ├── goQuorum
        │         ├── disallowed-nodes.json
        │         ├── genesis.json          -> qbft-4v-test/configmap/quorum-genesis-configmap.yaml
        │         ├── permissioned-nodes.json
        │         └── static-nodes.json
        ├── README.md
        ├── userData.json
        ├── validator0 
        │         ├── accountAddress
        │         ├── accountKeystore      -> qbft-4v-test/secrets/validator1-keys-secret.yaml
        │         ├── accountPassword      -> qbft-4v-test/secrets/validator1-keys-secret.yaml
        │         ├── accountPrivateKey
        │         ├── address
        │         ├── nodekey              -> qbft-4v-test/secrets/validator1-keys-secret.yaml
        │         └── nodekey.pub          -> qbft-4v-test/configmap/quorum-validators-configmap.yaml
        ├── validator1
        │         ├── accountAddress
        │         ├── accountKeystore      -> qbft-4v-test/secrets/validator2-keys-secret.yaml
        │         ├── accountPassword      -> qbft-4v-test/secrets/validator2-keys-secret.yaml
        │         ├── accountPrivateKey
        │         ├── address
        │         ├── nodekey              -> qbft-4v-test/secrets/validator2-keys-secret.yaml
        │         └── nodekey.pub          -> qbft-4v-test/configmap/quorum-validators-configmap.yaml
        ├── validator2
        │         ├── accountAddress
        │         ├── accountKeystore      -> qbft-4v-test/secrets/validator3-keys-secret.yaml
        │         ├── accountPassword      -> qbft-4v-test/secrets/validator3-keys-secret.yaml
        │         ├── accountPrivateKey
        │         ├── address
        │         ├── nodekey              -> qbft-4v-test/secrets/validator3-keys-secret.yaml
        │         └── nodekey.pub          -> qbft-4v-test/configmap/quorum-validators-configmap.yaml
        └── validator3
                  ├── accountAddress
                  ├── accountKeystore      -> qbft-4v-test/secrets/validator4-keys-secret.yaml
                  ├── accountPassword      -> qbft-4v-test/secrets/validator4-keys-secret.yaml
                  ├── accountPrivateKey
                  ├── address
                  ├── nodekey              -> qbft-4v-test/secrets/validator4-keys-secret.yaml
                  └── nodekey.pub          -> qbft-4v-test/configmap/quorum-validators-configmap.yaml
```

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
