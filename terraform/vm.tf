resource "google_compute_instance" "frontend_vm" {
  name         = "frontend-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network    = google_compute_network.vpc1.id
    subnetwork = google_compute_subnetwork.subnet1.id

    access_config {}
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt update
    apt install -y apache2
    systemctl start apache2
    echo "<h1>Frontend is working</h1>" > /var/www/html/index.html
  EOF
}

resource "google_compute_instance" "backend_vm" {
  name         = "backend-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network    = google_compute_network.vpc2.id
    subnetwork = google_compute_subnetwork.subnet2.id

    access_config {}
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt update
    apt install -y python3-pip
    pip3 install flask
    cat <<EOT > /home/app.py
    from flask import Flask, jsonify
    app = Flask(__name__)
    @app.route('/')
    def home():
        return jsonify({"message": "Hello from backend"})
    app.run(host='0.0.0.0', port=5000)
    EOT
    python3 /home/app.py &
  EOF
}
