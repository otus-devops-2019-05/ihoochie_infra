output "all_external_ips" {
  value = "${google_compute_instance.app.*.network_interface.0.access_config.0.nat_ip}"
}

output "external_ip_0" {
  value = "${google_compute_instance.app.0.network_interface.0.access_config.0.nat_ip}"
}

output "load_balancer_ip" {
  value = "${google_compute_global_forwarding_rule.reddit-lb-global-forwarding-rule.ip_address}"
}
