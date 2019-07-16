terraform {
  required_version = "0.11.11"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region  = "${var.region}"
}


resource "google_compute_project_metadata" "ssh-key-appuser" {
  metadata {
    ssh-keys = <<EOF
appuser1:${var.public_key} appuser1
appuser2:${var.public_key} appuser2
appuser3:${var.public_key} appuser3
appuser4:${var.public_key} appuser4
appuser5:${var.public_key} appuser5
EOF
  }
}


resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }


  # metadata {
    # ssh-keys = "appuser:${file(var.public_key_path)}"
  # }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key)}"
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["reddit-app"]
}
