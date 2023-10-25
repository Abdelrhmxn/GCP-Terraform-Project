
resource "google_project_iam_member" "connnect-gke" {
  project = var.project
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.vm-serviceaccount.email}"
}

resource "google_project_iam_member" "connnect-artifactregistry" {
  project = var.project
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:${google_service_account.vm-serviceaccount.email}"
}

# ----------------------------------------------------
# ----------------------------------------------------



resource "google_project_iam_member" "read-artifactregistry" {
  project = var.project
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.cluster-serviceaccount.email}"
}

resource "google_project_iam_member" "Least-privilage-nodepool" {
  project = var.project
  role    = "roles/container.nodeServiceAccount"
  member  = "serviceAccount:${google_service_account.cluster-serviceaccount.email}"
}

 

