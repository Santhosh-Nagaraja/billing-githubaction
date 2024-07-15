##### Docker Image Build and Push ###################

resource "docker_image" "build_push" {
  name = "${var.image}:${var.image_tag}"
  build {
    context = "."
    tag     = ["${var.image}:${var.image_tag}"]
  }
  provisioner "local-exec" {
    # working_dir = "../iaas-jenkins-docker-gcp"
    command = "gcloud auth activate-service-account ${var.gcp_auth_email} --key-file=${var.credential} && gcloud auth configure-docker && docker push ${var.image}:${var.image_tag} && docker images"
  }
}

# ###########################################

resource "google_cloud_run_service" "billing_koyaca" {
  name       = var.service-name
  depends_on = [docker_image.build_push]
  location   = var.region
  template {
    spec {
      containers {
        ports {
          container_port = var.port
        }
        image = "${var.image}:${var.image_tag}"

      }

    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}


resource "google_cloud_run_service_iam_member" "run_all_users" {
  service  = google_cloud_run_service.billing_koyaca.name
  location = google_cloud_run_service.billing_koyaca.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
