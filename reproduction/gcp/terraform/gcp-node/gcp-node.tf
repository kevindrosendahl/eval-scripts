variable "name" {
    type = "string"
}

variable "ssh_key" {
    type = "string"
}

variable "machine_type" {
    type = "string"
}

output "public_ip" {
  value = "${google_compute_instance.instance.network_interface.0.access_config.0.nat_ip}"
}

output "internal_ip" {
  value = "${google_compute_instance.instance.network_interface.0.network_ip}"
}

resource "google_compute_instance" "instance" {
    name         = "${var.name}"
    machine_type = "${var.machine_type}"
    zone         = "us-west1-b"

    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-1804-lts"
        }
    }
    
    network_interface {
        network = "default"

        access_config {}
    }

    metadata = {
        sshKeys = "ubuntu:${file("${var.ssh_key}")}"
    }

    metadata_startup_script = <<EOF
    git clone https://github.com/kevindrosendahl/eval-scripts.git /home/ubuntu/eval-scripts &&
    chown -R ubuntu:ubuntu /home/ubuntu/eval-scripts
    EOF
}

