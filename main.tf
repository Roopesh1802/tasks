//create a vpc

resource "google_compute_network" "vpc_network" {
 project = "es-devops-sb"
 name = "vpc-network-jenkins"
 auto_create_subnetworks = false
 mtu = 1460

}
//creates firewall rule

resource "google_compute_firewall" "vpc_network" {

name = "test-firewall"
network = google_compute_network.vpc_network.name

allow {

 protocol = "tcp"
 ports = ["80", "22"]

}
//source_tags = ["web"]

 target_tags = ["sample"]
 source_ranges = ["0.0.0.0/0"]

}
//create a subnet

resource "google_compute_subnetwork" "network-with-ip-ranges" {
 name = "subnet-3"
 ip_cidr_range = "10.20.0.0/24"
 region = "us-central1"
 network  = google_compute_network.vpc_network.id
 private_ip_google_access = true

}

resource "google_compute_subnetwork" "network-with-ip-ranges-1" {

 name = "subnet-4"

 ip_cidr_range = "10.32.0.0/24"

 region = "us-west1"

 network  = google_compute_network.vpc_network.id

 private_ip_google_access = true



}





//creates instance template

resource "google_compute_instance_template" "instance_test" {

 count = 0
 name = "test-template"
 machine_type = "n1-standard-1"
 tags= ["sample"]

 disk{

  source_image = "centos-7-v20230306"
  disk_size_gb = 20

 }

 network_interface {

  network = "vpc-network-1"

  subnetwork = "subnet-3"
 # secret default

  access_config {
  network_tier = "PREMIUM"
 }

}

}
