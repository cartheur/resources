# Kubernetes

## Getting up and running on Minikube

1. Install Minikube
2. Create the `testing` namespace using `kubectl create namespace testing`
3. Switch into the `testing` namespace using `kubectl config set-context --current --namespace=testing`
2. Load the images from the repository into Minikube internal repository via `minikube image load <image>`, e.g.: `minikube image load mbsakswetestaccacr.azurecr.io/buma-stemra-mono/user-service:107.0`
3. Login to Azure via `az login` in order ot access the MBS-ACC-KV-01 Keyvault to create the credentials
4. Run `./deploy.sh`

Look into `deploy.sh` for more details on how to deploy the services. But the NodeJS stack should be fully running.

There is no ingress defined, we can just use `kubectl port-forward`.

Run the following port-forward commands:
- `kubectl port-forward services/frontend-service 3000:80`
- `kubectl port-forward services/api-gateway-service 3100:8080`

Testing the services:
- Frontend: `http://localhost:3000`
- API Gateway: `http://localhost:3100/graphql`
