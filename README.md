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
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/191bbbbf-20a5-4dd5-ac0d-c3f69967d419" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/09e87dc9-cef8-430a-9e51-c5be4fbc1537" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/504a9ead-1234-47c7-a4f7-ce4b1bfbb879" width="" height="" >

2. Get management-vm credentials to SSH it using IAP
```bash
gcloud compute ssh --zone "us-east1-b" "management-vm" --tunnel-through-iap --project "abdelrhmxn-gcp-project"
```
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/b6bfd60b-8286-4a58-91dc-05d7364f6ad3" width="" height="" >

3. Setup VM
- Download Kubectl and get-credentials of cluster
```bash
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin -y
sudo apt-get  install kubectl -y
gcloud container clusters get-credentials abdelrhmxn-gke-cluster --region us-central1 --project abdelrhmxn-gcp-project
```
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/18ab2b16-7cc5-457d-ae25-e1b7b182a763" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/65842cda-a251-42a9-9b65-d62a3c31663d" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/6d6c0d6f-bf5c-47b2-901b-d7e1d1722e99" width="" height="" >


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
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/37bf4645-4258-4c71-bfd0-669763a3ef18" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/7d0fef37-57ca-4920-8213-1e620ca50b79" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/ae816aa1-30a2-4c8f-9c9f-d5a3c754ff17" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/23bd8145-0293-4051-8e23-868385f3550f" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/f32c0dca-799a-4f8e-8907-5d784dd4a7a0" width="" height="" >

- Complete Authentication with Artifact Registry
```bash
gcloud auth print-access-token --impersonate-service-account vm-serviceaccount@abdelrhmxn-gcp-project.iam.gserviceaccount.com | sudo docker login -u oauth2accesstoken --password-stdin https://us-central1-docker.pkg.dev
```
- Copy your manifest to VM ( USE THIS COMMAND IN YOUR LOCAL MACHINE ) 
```bash
gcloud compute scp --zone "us-east1-b"  --recurse manifest/* abdelrhman@management-vm:/home/abdelrhman --tunnel-through-iap --project "abdelrhmxn-gcp-project"
```
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/e2cec0ff-177e-4956-89cc-ab26c197593b" width="" height="" >

4. Dockerize your applications
```bash
 docker build -t [IMAGE NAME] .  
```
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/fd9493a8-5b1c-4225-b7c3-5578d8b6a4d4" width="" height="" >

5. Push them to Artifact Registry
```bash
docker tag [IMAGE NAME] [artifactrepositorylocation/IMAGE-NAME]
gcloud auth configure-docker us-central1-docker.pkg.dev
docker push [NEW IMAGE NAME]
```
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/81b40087-cee1-4883-ad69-fe59158b82a8" width="" height="" >

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
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/c8529b43-ec05-499e-abc4-c6630ce9a7fa" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/ac993c4e-3912-4e93-97bd-10d497b92eee" width="" height="" >
<img src="https://github.com/Abdelrhmxn/GCP-Terraform-Project/assets/55556764/70099e6d-921b-417e-99b6-93afc2b9c1a0" width="" height="" >
