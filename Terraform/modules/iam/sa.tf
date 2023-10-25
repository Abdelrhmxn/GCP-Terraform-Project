resource "google_service_account" "vm-serviceaccount" {
  account_id   = "vm-serviceaccount"
  display_name = "Service Account For Management-VM To Control GKE Cluster And Artifact Registry"
}

resource "google_service_account" "cluster-serviceaccount" {
  account_id   = "cluster-serviceaccount"
  display_name = "Service Account For Workload To Access Artifact registry"
}


 