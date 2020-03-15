variable "project" {
  type         = string
  default      = "test-21111992"
}

variable "region" {
  type         = string
  default      = "europe-west4"
}

variable "name" {
  type        = string
  default     = "gke-cluster"
}

variable "initial_node_count" {
  default   = 1
}

variable "limit_node_count" {
  default   = 3
}

variable "node_name" {
  type      = string
  default   = "my-node-pool"
}

variable "machine_type" {
  type       = string
  default    = "n1-standard-1"
}

variable "oauth_scopes" {
  type      = list(string)
  default   = [
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",]
}