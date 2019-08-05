# output "all_external_ips" {
#   value = "${google_compute_instance.app.*.network_interface.0.access_config.0.nat_ip}"
# }

output "db_external_ip" {
  value = "${module.db.db_external_ip}"
}

output "app_external_ip" {
  value = "${module.app.app_external_ip}"
}

output "db_internal_ip" {
	value = "${module.db.db_internal_ip}"
}

# output "load_balancer_ip" {
#   value = "${google_compute_global_forwarding_rule.reddit-lb-global-forwarding-rule.ip_address}"
# }

