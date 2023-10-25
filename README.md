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
### How to use it
1. Apply Terraform Code
```bash
Terraform apply 
```
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/6160307f-780f-4ab3-8436-a3b7c79d0803" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/e5177928-49a7-4b16-9736-ff3bb9ec5fd1" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/be4912fb-95af-4dce-afbf-566890d3afdd" width="" height="" >

2. Get management-vm credentials to SSH it using IAP
```bash
gcloud compute ssh --zone "us-east1-b" "management-vm" --tunnel-through-iap --project "abdelrhmxn-gcp-project"
```
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/6ee7e981-d3c5-48ae-be74-8d136679b2d8" width="" height="" >

3. Setup VM
- Download Kubectl and get-credentials of cluster
```bash
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin -y
sudo apt-get  install kubectl -y
gcloud container clusters get-credentials abdelrhmxn-gke-cluster --region us-central1 --project abdelrhmxn-gcp-project
```
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/5b37d498-d6c8-4af1-b0cc-d84e29fdd28f" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/3a407bc7-3965-4237-b73e-c51a443816a0" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/9acc7a8a-cc0a-44fc-9509-57ccc99e7f08" width="" height="" >


- Download Docker
```bash
sudo apt update
sudo apt upgrade
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
```
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/d76999e9-2055-468c-96aa-ce78a60b72f8" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/efb07613-2759-45b4-a6f4-472ec51f60bd" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/9baeb10a-573e-46e8-b9bc-1a0b74481343" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/fd1baffd-a56e-4bea-80e0-5e82833390b7" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/c93882bb-0d6f-43e3-969d-cdf1ecc55e1a" width="" height="" >

- Complete Authentication with Artifact Registry
```bash
gcloud auth print-access-token --impersonate-service-account vm-serviceaccount@abdelrhmxn-gcp-project.iam.gserviceaccount.com | sudo docker login -u oauth2accesstoken --password-stdin https://us-central1-docker.pkg.dev
```
- Copy your manifest to VM ( USE THIS COMMAND IN YOUR LOCAL MACHINE ) 
```bash
gcloud compute scp --zone "us-east1-b"  --recurse manifest/* abdelrhman@management-vm:/home/abdelrhman --tunnel-through-iap --project "abdelrhmxn-gcp-project"
```
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/5dbbfb6e-025e-4a1f-9b64-5069be149361" width="" height="" >

4. Dockerize your applications
```bash
 docker build -t [IMAGE NAME] .  
```
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/ae7eab93-c57f-4839-9c9d-008196f37753" width="" height="" >

5. Push them to Artifact Registry
```bash
docker tag [IMAGE NAME] [artifactrepositorylocation/IMAGE-NAME]
gcloud auth configure-docker us-central1-docker.pkg.dev
docker push [NEW IMAGE NAME]
```
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/e98000ac-00fa-4dfa-926d-7d05e440923b" width="" height="" >

6. Apply manifest files
```bash
kubectl apply -f Secret.yml
kubectl apply -f sa-secret.yml
kubectl apply -f serviceAccount.yml
kubectl apply -f Role.yml
kubectl apply -f Service.yml
kubectl apply -f volume.yml
kubectl apply -f mongodb.yml
kubectl apply -f App.yml
```
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/9e3c5622-f28b-4e13-83d1-192f6d500a25" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/9e515345-12fc-494b-bcf8-f3e5ac6a745a" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/9ac05257-0e58-46c6-8bb9-aafe71669b26" width="" height="" >
