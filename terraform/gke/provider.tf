provider "google" {
  credentials = file("~/.config/gcloud/terraform-admin.json")
  project     = var.project
  region      = var.region
}
