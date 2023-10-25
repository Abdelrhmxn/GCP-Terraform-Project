terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.84.0"
    }
  }
}

provider "google" {
  project     = var.project
  credentials = file("abdelrhmxn-gcp-project-fee4707bc2ea.json")
  region      = var.region
  zone        = var.zone
}



 