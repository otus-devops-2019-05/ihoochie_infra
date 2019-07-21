variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable zone {
  description = "Zone"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable private_key {
  description = "Path to the privat key uset for ssh access in the provisoners"
}

variable "db_internal_ip" {
  description = "DB internal ip to connect the app"
  default     = "127.0.0.1"
}
