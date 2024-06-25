## aeon-working-directory

Cloudy, in here, ain't it?

### Deployment sequence criteria

THe word is: "all of them can go simultanious, but api-gateway as last one" meaning the order is up to me. Gateway obviously last, no problems. Will see.

### The Plan

Deploy in this order

* Platform-API
* Statement-API
* User-API
* Member-Portal
* Frontend
* Works-API
* API-Gateway

Check-into the keyvault script as it might prove handy at a later point in the aiventure.

### Sequential commands

The `deploy` directory as root.

* `kubectl create namespace testing --dry-run=none`

* `kubectl apply -f platform-api.deployment.yml --dry-run=server`
* `kubectl apply -f platform-api.configmap.yml`
* `kubectl apply -f platform-api.service.yml`

* `kubectl apply -f statement-api.deployment.yml`
* `kubectl apply -f statement-api.configmap.yml`
* `kubectl apply -f statement-api.service.yml`

* `kubectl apply -f user-api.deployment.yml`
* `kubectl apply -f user-api.configmap.yml`
* `kubectl apply -f user-api.service.yml`

* `kubectl apply -f member-portal.deployment.yml`
* `kubectl apply -f member-portal.configmap.yml`
* `kubectl apply -f member-portal.ingress.yml`
* `kubectl apply -f member-portal.service.yml`

* `kubectl apply -f frontend.deployment.yml`
* `kubectl apply -f frontend.configmap.yml`
* `kubectl apply -f frontend.ingress.yml`
* `kubectl apply -f frontend.service.yml`

* `kubectl apply -f works-api.deployment.yml`
* `kubectl apply -f works-api.configmap.yml`
* `kubectl apply -f works-api.service.yml`

* `kubectl apply -f api-gateway.deployment.yml`
* `kubectl apply -f api-gateway.configmap.yml`
* `kubectl apply -f api-gateway.ingress.yml`
* `kubectl apply -f api-gateway.service.yml`

### Observed errors

```
docker run -it mbsakswetestaccacr.azurecr.io/member-portal:103.0

Fatal error: Uncaught Symfony\Component\Dotenv\Exception\PathException: Unable to read the "/var/www/symfony/bin/../.env" environment file. in /var/www/symfony/vendor/symfony/dotenv/Dotenv.php:514
Stack trace:
#0 /var/www/symfony/vendor/symfony/dotenv/Dotenv.php(65): Symfony\Component\Dotenv\Dotenv->doLoad(false, Array)
#1 /var/www/symfony/bin/console(22): Symfony\Component\Dotenv\Dotenv->load('/var/www/symfon...')
#2 {main}
  thrown in /var/www/symfony/vendor/symfony/dotenv/Dotenv.php on line 514

```