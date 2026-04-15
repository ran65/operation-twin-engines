
resource "google_compute_network" "vpc1" {
  name = "vpc-frontend"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "subnet-frontend"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc1.id
}

resource "google_compute_network" "vpc2" {
  name = "vpc-backend"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet2" {
  name          = "subnet-backend"
  ip_cidr_range = "10.0.2.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc2.id
}
