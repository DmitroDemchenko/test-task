# Prepare kubernetes cluster in GKE using terraform:
##### 1.1 Create project with name `test-21111992` or create your own and replace this value into `terraform/variable.tf -> project`
##### 1.2 Create service account with Editor Role
##### 1.3 Generate key in json format and save it as terraform-admin.json in `~/.config/gcloud/`
##### 1.4 Go to terraform folder and execute terraform init to initialize plugins
##### 1.5 Execute terraform apply form terraform folder and waite until cluster will be created in you project
##### 1.6 Switch on new cluster
###### 1.6.1 Get list of clusters:
```
gcloud container clusters list
```
###### 1.6.2 Get credentials:
```
gcloud container clusters get-credentials my-gke-cluster --zone us-central1
```
# Install helm chart with backend service.

## 2.1 If you use your own project, you have to create Google Container Registery and push image there.
###### 2.1.1 Execute image build:
```
cd images/parser
docker build -t parser .
```
###### 2.1.2. Create tag for image
```
docker tag parser eu.gcr.io/${project_name}/parser:1.1.0
```
###### 2.1.3. Push image into GCR
```
docker push eu.gcr.io/${project_name}/parser:1.1.0
```
###### 2.1.4 Replace image PATH in helm values
```
cd helm/application/backend
in values.yaml replace image.repository value
```
##### 2.2 Create service account to get access to GCR
###### 2.2.1 Create SA with Editor role and generate key in json format
###### 2.2.2 Create secret for GCR:
```
kubectl create secret -n application docker-registry helm-secret  \
--docker-server=eu.gcr.io \
--docker-username=_json_key \
--docker-password="$(cat ./helm-secret.json)" \
--docker-email="$EMAIL"
```
> I've used helm3 in my project, so I have to create namespace before install helm chart
```
kubectl create namespace application
```
##### 2.3 Execute helm install:
```
helm install backend ./helm/application/backend -n application
```
##### 2.4 Check scaling of pods:
```
kubectl scale --replicas=2 deployment.apps/parser -n application
```
# Install monitoring:
##### 3.1 Create namespace before install helm chart:
```
kubectl create namespace monitoring
```
##### 3.2 Download dependency helm charts localy:
```
helm dep up monitoring
```
##### 3.3 Install helm chart:
```
helm install monitoring helm/application/monitoring/ -n monitoring
```

