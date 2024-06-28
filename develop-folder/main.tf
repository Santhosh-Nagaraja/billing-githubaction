terraform {
  required_version = ">= 0.14"

  required_providers {
    # Cloud Run support was added on 3.3.0
    google = ">= 3.3"

    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }

  }
}

##### Docker Image Build and Push ###################

resource "docker_image" "zoo" {
  name = "${var.image}:${var.image_tag}"
  build {
    context = "."
    tag     = ["${var.image}:${var.image_tag}"]
  }
  provisioner "local-exec" {
    # working_dir = "../iaas-jenkins-docker-gcp"
    command = "gcloud auth activate-service-account ${var.gcp_auth_email} --key-file=${var.credential} && gcloud auth configure-docker && docker push ${var.image}:${var.image_tag} && docker images && gcloud run deploy ${var.cloud-run-svc-name} --image ${var.image}:${var.image_tag} --region ${var.region} --platform managed"
  }
}
