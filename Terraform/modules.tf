module "network" {
  source = "./modules/network"
  cidr-workload-subnet = var.cidr-workload-subnet
  cidr-management-subnet= var.cidr-management-subnet
  region-workload-subnet=  var.region-workload-subnet
  region-management-subnet= var.region-management-subnet
  project= var.project
}

module "storage" {
  source = "./modules/storage"
  artifactregistry-format = var.artifactregistry-format
  artifactregistry-region = var.artifactregistry-region
}

module "iam" {
  source = "./modules/iam"
  project = var.project
}

module "compute" {
  source = "./modules/compute"
  image-vm = var.image-vm
  zone-vm = var.zone-vm
  type-vm = var.type-vm
  gke-location = var.gke-location
  vm-service_account = module.iam.vm-service_account-email
  cluster-serviceaccount = module.iam.cluster-service_account-email
  management-subnet-id = module.network.management-subnet-id
  network-id = module.network.network-id
  workload-subnet-id = module.network.workload-subnet-id
}