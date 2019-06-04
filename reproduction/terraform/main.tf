variable "project_name" {
    type = "string"
}

provider "google" {
 project = "${var.project_name}"
 region  = "us-west1"
 zone    = "us-west1b"
}

resource "google_compute_instance" "a" {
    name         = "a"
    machine_type = "n1-highcpu-8"
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
        sshKeys = "ubuntu:${file("~/.ssh/id_rsa-github.pub")}"
    }
}

resource "google_compute_instance" "b" {
    name         = "b"
    machine_type = "n1-highcpu-8"
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
        sshKeys = "ubuntu:${file("~/.ssh/id_rsa-github.pub")}"
    }
}
