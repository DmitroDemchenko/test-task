resource "google_container_cluster" "primary" {
  name     = var.name
  location = var.region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.node_name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.initial_node_count
  autoscaling {
    min_node_count = var.initial_node_count
    max_node_count = var.limit_node_count
  }

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = var.oauth_scopes
  }
}

