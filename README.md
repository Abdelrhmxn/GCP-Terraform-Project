# GCP-Terraform-Project
This project will assess your Google Cloud, Networking, DB, Development,
Terraform, Docker, and Kubernetes skills.
In this project you will deploy a simple Node.js web application (stateless) that
interacts with a highly available MongoDB (stateful) replicated across 3 zones
and consisting of 1 primary and 2 secondaries.

## Description
1. Develop and use your own Terraform modules to build the required infrastructure
on GCP:
      - IAM: 2 service accounts - N roles.
      - Network: 1 VPC – 2 subnets – N firewall rules – 1 NAT.
      - Compute: 1 private VM – 1 GKE standard cluster across 3 zones.
      - Storage: Artifact Registry repository to store the images.
3. Deploy the MongoDB replicaset across the 3 zones.
4. Dockerize and Deploy the Node.js web app that will connect to the 3 DB replicas.
5. Expose the web app using ingress/load balancer.
6. (Bonus) Enable IAP on the load balancer to accept traffic from allowed users
only.

## Getting Started
### Dependencies
- Docker
- Terraform
- Kubectl
### Executing program
1. Apply Terraform Code
```bash
Terraform apply 
```
2. Get management-vm credentials to SSH it
```bash
gcloud compute ssh --zone "us-east1-b" "management-vm" --tunnel-through-iap --project "abdelrhmxn-gcp-project"
```
3. Setup VM
- Download Kubectl and get-credentials of cluster
```bash
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin -y
sudo apt-get  install kubectl -y
gcloud container clusters get-credentials abdelrhmxn-gke-cluster --region us-central1 --project abdelrhmxn-gcp-project
```
- Download Docker
```bash
sudo apt update
sudo apt upgrade
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
```
- Complete Authentication with Artifact Registry
```bash
gcloud auth print-access-token --impersonate-service-account vm-serviceaccount@abdelrhmxn-gcp-project.iam.gserviceaccount.com | sudo docker login -u oauth2accesstoken --password-stdin https://us-central1-docker.pkg.dev
```
- Copy your manifest to VM ( USE THIS COMMAND IN YOUR LOCAL MACHINE ) 
```bash
gcloud compute scp --zone "us-east1-b"  --recurse manifest/* abdelrhman@management-vm:/home/abdelrhman --tunnel-through-iap --project "abdelrhmxn-gcp-project"
```
4. Dockerize your applications
```bash
 docker build -t [IMAGE NAME] .  
```
5. Push them to Artifact Registry
```bash
docker tag [IMAGE NAME] [artifactrepositorylocation/IMAGE-NAME]
gcloud auth configure-docker us-central1-docker.pkg.dev
docker push [NEW IMAGE NAME]
```
6. Apply manifest files
```bash
kubectl apply -f Manifest/Secret.yml
kubectl apply -f Manifest/sa-secret
kubectl apply -f Manifest/serviceAccount.yml
kubectl apply -f Manifest/Role.yml
kubectl apply -f Manifest/Service.yml
kubectl apply -f Manifest/volume.yml
kubectl apply -f Manifest/mongodb.yml
kubectl apply -f Manifest/App.yml
```




