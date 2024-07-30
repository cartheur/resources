SERVICES=("works-api" "user-api" "statement-api" "api-gateway" "frontend")

# create config maps
for SERVICE in "${SERVICES[@]}"; do
    echo "Deploying config map for $SERVICE..."
    ./keyvault-replace.sh "./$SERVICE.configmap.yaml" MBS-ACC-KV-01 | kubectl apply -f -
done

# deploy deployments
for SERVICE in "${SERVICES[@]}"; do
    echo "Deploying deployments for $SERVICE..."
    kubectl apply -f "./$SERVICE.deployment.yaml"
done

kubectl apply -f ./redis.yaml

# deploy services
for SERVICE in "${SERVICES[@]}"; do
    echo "Deploying services for $SERVICE..."
    kubectl apply -f "./$SERVICE.service.yaml"
done


# rollout restart
for SERVICE in "${SERVICES[@]}"; do
    echo "Rolling out $SERVICE..."
    kubectl rollout restart deployment $SERVICE
done
