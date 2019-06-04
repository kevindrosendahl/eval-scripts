variable "ssh_key" {
    type = "string"
}

variable "machine_type" {
    type = "string"
    default = "n1-highcpu-8"
}

resource "google_compute_instance" "a" {
    name         = "a"
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
        sshKeys = "ubuntu:${file(${var.ssh_key})}"
    }

    metadata_startup_script = "git clone https://github.com/kevindrosendahl/eval-scripts.git && ./eval-scripts/reproduction/setup.sh"
}

