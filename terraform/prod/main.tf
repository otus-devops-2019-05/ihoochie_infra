terraform {
  # required_version = "0.11.11"
  required_version = ">= 0.11.7"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  private_key     = "${var.private_key}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
  db_internal_ip  = "${module.db.db_internal_ip}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  private_key     = "${var.private_key}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["46.188.121.36/32"]
}

resource "google_compute_project_metadata" "ssh-key-appuser" {
  metadata {
    ssh-keys = <<EOF
appuser:${var.public_key} appuser
# appuser1:${var.public_key} appuser1
# appuser2:${var.public_key} appuser2
# appuser3:${var.public_key} appuser3
# appuser4:${var.public_key} appuser4
# appuser5:${var.public_key} appuser5
EOF
  }
}
