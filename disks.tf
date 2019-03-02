data "google_compute_image" "rancher_ha_node_image" {
  family  = "ubuntu-1604-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_disk" "rancher_ha_disk" {
  name   = "rancher-ha-disk"
  zone = "europe-west2-a"
  type   = "pd-ssd"
  image  = "${data.google_compute_image.rancher_ha_node_image.self_link}"
}
