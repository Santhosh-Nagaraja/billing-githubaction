provider "google" {
  project     = "dfpsjifsd"
  region      = "us-central1"
  credentials = file("./creden.json")
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.31.1"
    }
  } 
}
 
resource "google_cloud_run_service" "default" {
  name     = "cloudrun-srv"
  location = "us-central1"
  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
