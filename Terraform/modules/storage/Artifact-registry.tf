resource "google_artifact_registry_repository" "my-repo" {
  location      = var.artifactregistry-region
  repository_id = "my-repository"
  description   = "Docker Repository"
  format        = var.artifactregistry-format
} 