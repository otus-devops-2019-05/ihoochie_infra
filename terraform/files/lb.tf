resource "google_compute_instance_group" "reddit-instance-group" {
  name        = "reddit-instance-group"
  description = "Reddit instance group"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  named_port {
    name = "reddit-http-named-port"
    port = "9292"
  }

  zone = "${var.zone}"
}

resource "google_compute_health_check" "reddit-health-check" {
  name               = "reddit-health-check"
  timeout_sec        = 5
  check_interval_sec = 10

  tcp_health_check {
    port = "9292"
  }
}

resource "google_compute_firewall" "fw-allow-health-checks" {
  name    = "fw-allow-health-checks"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  target_tags   = ["allow-health-checks"]
  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  priority      = 1000
  direction     = "INGRESS"
}

# Frontend configuration
resource "google_compute_global_forwarding_rule" "reddit-lb-global-forwarding-rule" {
  name       = "reddit-lb-global-forwarding-rule"
  target     = "${google_compute_target_http_proxy.reddit-lb-target-proxy.self_link}"
  port_range = "80"
}

resource "google_compute_target_http_proxy" "reddit-lb-target-proxy" {
  name        = "reddit-lb-target-proxy"
  description = "target-proxy"
  url_map     = "${google_compute_url_map.reddit-lb-url-map.self_link}"
}

# Host and path rules, also Load Balancer name
resource "google_compute_url_map" "reddit-lb-url-map" {
  name            = "reddit-load-balancer"
  description     = "url-map"
  default_service = "${google_compute_backend_service.reddit-lb-backend-service.self_link}"
}

resource "google_compute_backend_service" "reddit-lb-backend-service" {
  name        = "reddit-lb-backend-service"
  port_name   = "reddit-http-named-port"
  protocol    = "HTTP"
  timeout_sec = 30

  backend = {
    group = "${google_compute_instance_group.reddit-instance-group.self_link}"
  }

  health_checks = ["${google_compute_health_check.reddit-health-check.self_link}"]
}
