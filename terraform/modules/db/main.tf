resource "google_compute_instance" "db" {
  name         = "reddit-db"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-db"]

  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key)}"
  }

  provisioner "file" {
    source      = "${path.module}/files/mongod.conf"
    destination = "/tmp/mongod.conf"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/bind_ip.sh"
  }

  # metadata {
  #   ssh-keys = "appuser:${file(var.public_key_path)}"
  # }
}

# Правило firewall
resource "google_compute_firewall" "firewall_mongo" {
  name    = "allow-mongo-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  target_tags = ["reddit-db"]
  source_tags = ["reddit-app"]
}
