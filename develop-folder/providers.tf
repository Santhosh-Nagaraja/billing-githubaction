
provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = file("./${var.credential}")
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
