resource "google_compute_network" "network" {
  name                    = "network1"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "subnetwork1"
  ip_cidr_range = "192.168.0.0/24"
  network       = "${google_compute_network.network.self_link}"
}

resource "google_compute_firewall" "firewall" {
  name    = "firewall"
  network = "${google_compute_network.network.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
}

resource "google_compute_instance" "vm1" {
  name = "vm1"
  machine_type = "n1-standard-1"
  metadata_startup_script = "${file("./install-nginx.sh")}"
  disk {
    image = "debian-cloud/debian-8"
  }

  zone = "europe-west1-b"

  network_interface {
    subnetwork = "subnetwork1"
    access_config {
      // Ephemeral IP : The Ip address will be available until the instance is alive, when the stack is destroy and apply again, the public Ip is a new one
    }
  }
}

resource "google_compute_instance" "vm2" {
  name = "vm2"
  machine_type = "n1-standard-1"
  metadata_startup_script = "${file("./install-nginx.sh")}"
  disk {
    image = "debian-cloud/debian-8"
  }

  zone = "europe-west1-c"

  network_interface {
    subnetwork = "subnetwork1"
    access_config {
      // Ephemeral IP : The Ip address will be available until the instance is alive, when the stack is destroy and apply again, the public Ip is a new one
    }
  }
}
