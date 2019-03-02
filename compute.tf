resource "google_compute_instance_template" "rancher_ha_compute_template" {
  name                 = "rancher-ha-node-template"
  description          = "Instance template to represent the Compute Nodes which make up the HA Rancher Cluster"
  machine_type         = "n1-standard-2"
  tags                 = ["rancher-ha-node"]
  instance_description = "Rancher HA Node"
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

 disk {
   source_image = "${data.google_compute_image.rancher_ha_node_image.self_link}"
   disk_size_gb = "64"
   auto_delete = false
   boot = true
 }

  network_interface {
    network = "${google_compute_network.rancher_ha_network.name}"
    access_config {
      
    }
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  lifecycle {
    create_before_destroy = true
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get --assume-yes install apt-transport-https ca-certificates curl gnupg-agent software-properties-common && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo apt-key fingerprint 0EBFCD88 && sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" && sudo apt-get --assume-yes update && sudo apt-get --assume-yes install docker-ce=5:18.09.2~3-0~ubuntu-xenial docker-ce-cli=5:18.09.2~3-0~ubuntu-xenial containerd.io"
}
 
resource "google_compute_instance_group_manager" "rancher_ha_node_group_manager" {
  name               = "rancher-ha-node-group-manager"
  instance_template  = "${google_compute_instance_template.rancher_ha_compute_template.self_link}"
  base_instance_name = "instance-group-manager"
  target_size        = "3"
  zone = "europe-west2-a"
}