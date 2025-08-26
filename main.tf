provider "google" {
  project = "di-gcp-351221"
  region  = "us-central1"
  zone    = "us-central1-a"
}


resource "google_compute_network" "my_vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "my_subnet" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.my_vpc.id
}


resource "google_compute_firewall" "allow_3000" {
  name    = "allow-port-3000"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["3000"]
  }

  source_ranges = ["0.0.0.0/0"]
}


resource "google_compute_instance" "VM_instance_deployment" {
  name         = "VM_instance_deployment"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.my_vpc.id
    subnetwork = google_compute_subnetwork.my_subnet.id
    access_config {} # This gives it an external IP
  }

  metadata = {
    ssh-keys = "YOUR_USERNAME:${file("~/.ssh/id_rsa.pub")}"
  }

  tags = ["node-app"]
}
