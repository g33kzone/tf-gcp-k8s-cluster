provider "google" {
  credentials = "${file("/home/mwar/Cloud/GCP/devops/devops-260809-1f72ec5132b0.json")}"
  project = "devops-260809"
}

resource "google_project_service" "kubernetes" {
  project = "devops-260809"
  service = "container.googleapis.com"
}

resource "google_container_cluster" "kubernetes" {
  name               = "k8s-cluster"
  depends_on         = ["google_project_service.kubernetes"]
  initial_node_count = 1
  location = "us-central1"
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    tags = ["network-cluster"]
  }
}