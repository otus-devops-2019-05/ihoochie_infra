variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key {
  description = "Path to the privat key uset for ssh access in the provisoners"
}

variable zone {
  description = "Zone for instance"
  default     = "europe-west1-b"
}

variable disk_image {
  description = "Disk image"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable public_key {
  description = "Public ssh key"
}

variable instance_count {
  description = "Namber of instances"
  default     = 1
}
