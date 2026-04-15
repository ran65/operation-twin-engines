resource "google_compute_firewall" "allow_icmp" {
  name    = "allow-icmp"
  network = google_compute_network.vpc1.name

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.0.2.0/24"]
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.vpc1.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_backend" {
  name    = "allow-backend"
  network = google_compute_network.vpc2.name

  allow {
    protocol = "tcp"
    ports    = ["5000"]
  }

  source_ranges = ["10.0.1.0/24"]
}
