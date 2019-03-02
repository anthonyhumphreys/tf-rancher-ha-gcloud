resource "google_compute_firewall" "rancher_ha_firewall" {
  name    = "ha-nodes-firewall"
  network = "${google_compute_network.rancher_ha_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "2376", "2379", "2380", "9099", "10250", "6443", "10254", "30000-32767"]
  }

  allow {
    protocol = "udp"
    ports    = ["4789", "8472", "30000-32767"]
  }

  source_tags = ["rancher-ha-node"]
}

resource "google_compute_network" "rancher_ha_network" {
  name = "rancher-ha-network"
}

resource "google_compute_forwarding_rule" "rancher_ha_forwarding_http" {
  name       = "rancher-ha-forwarding-rule-http"
  target     = "${google_compute_target_pool.default.self_link}"
  port_range = "80"
}

resource "google_compute_forwarding_rule" "rancher_ha_forwarding_https" {
  name       = "rancher-ha-forwarding-rule-https"
  target     = "${google_compute_target_pool.default.self_link}"
  port_range = "443"
}

resource "google_compute_target_pool" "default" {
  name      = "rancher-ha-target-pool"
}
