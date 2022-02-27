1.Install kubecolor
```bash
wget https://github.com/hidetatz/kubecolor/releases/download/v0.0.20/kubecolor_0.0.20_Linux_x86_64.tar.gz && \
tar zvxf kubecolor_0.0.20_Linux_x86_64.tar.gz && \
cp kubecolor /usr/local/bin/
```{{execute}}

`kubecolor version`{{execute}}

`kubecolor get pod -A`{{execute}}

2.Install Minio
```bash
MINIO_ROOT_USER=$(< /dev/urandom tr -dc a-z | head -c${1:-4})
MINIO_ROOT_PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-8})
MINIO_PORT="9010"
```{{execute}}

```bash
docker run -it -d --rm -v ~/.minio-data/:/data --name minio-4-spinnaker -p ${MINIO_PORT}:${MINIO_PORT} \
-e MINIO_ROOT_USER=${MINIO_ROOT_USER} -e  MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD} \
 minio/minio  server /data --address :${MINIO_PORT}
```{{execute}}

```bash
echo "
MINIO_ROOT_USER=${MINIO_ROOT_USER}
MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD}
ENDPOINT=http://$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' minio-4-spinnaker):${MINIO_PORT}
"
```{{execute}}

3.Deploy Halyard
```bash
docker run -itd --name halyard --rm --network host  -v ~/.hal:/home/spinnaker/.hal \
-v ~/.kube/:/home/spinnaker/.kube -v ~/.kube/:/root/.kube -v ~/.minikube/:/root/.minikube -it ghcr.io/ahmetozer/halyard-container
```{{execute}}

`docker exec -it halyard bash`{{execute}}

4.Setting up the provider
```bash
CONTEXT=$(kubectl config current-context)
kubectl apply --context $CONTEXT \
    -f https://spinnaker.io/downloads/kubernetes/service-account.yml
```{{execute}}

```bash
TOKEN=$(kubectl get secret --context $CONTEXT \
   $(kubectl get serviceaccount spinnaker-service-account \
       --context $CONTEXT \
       -n spinnaker \
       -o jsonpath='{.secrets[0].name}') \
   -n spinnaker \
   -o jsonpath='{.data.token}' | base64 --decode)
   
kubectl config set-credentials ${CONTEXT}-token-user --token $TOKEN
kubectl config set-context $CONTEXT --user ${CONTEXT}-token-user   
```{{execute}}

```bash
hal config provider kubernetes enable

ACCOUNT="my-k8s-account"
hal config provider kubernetes account add ${ACCOUNT} \
    --context ${CONTEXT}
```{{execute}}

`hal config deploy edit --type distributed --account-name $ACCOUNT`{{execute}}

5.Setting up the Storage
```bash
DEPLOYMENT="default"
mkdir -p ~/.hal/$DEPLOYMENT/profiles/
echo spinnaker.s3.versioning: false > ~/.hal/$DEPLOYMENT/profiles/front50-local.yml

###### ${MINIO_ROOT_PASSWORD}
###### ${MINIO_ROOT_USER}

echo ${MINIO_ROOT_PASSWORD} | hal config storage s3 edit --endpoint $ENDPOINT \
    --access-key-id ${MINIO_ROOT_USER} \
    --secret-access-key
```{{execute}}

```bash
hal config storage edit --type s3
hal config storage s3 edit --path-style-access=true
```{{execute}}

6.Deploy Spinnaker    
`hal config version edit --version  1.26.6`{{execute}}

`hal deploy apply`{{execute}}
