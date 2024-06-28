variable "project" {
  type        = string
  description = "Enter Your Project Id"
}

variable "region" {
  type        = string
  description = "Enter Your region"
}

variable "zone" {
  type        = string
  description = "Enter Your Zone"
}

variable "credential" {
  type        = string
  description = "Enter your credential file path"
}

variable "gcp_auth_email" {
  type        = string
  description = "Enter your Service Account Email"
}

variable "image" {
  type        = string
  description = "Enter your Docker Image Name"
}


variable "image_tag" {
  type        = string
  description = "Enter your Docker Image tag"
}

variable "cloud-run-svc-name" {
  type        = string
  description = "Enter your Docker Image tag"
}
