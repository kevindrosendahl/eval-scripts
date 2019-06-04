variable "project_name" {
    type = "string"
}

variable "ssh_key" {
    type = "string"
}

variable "machine_type" {
    type = "string"
    default = "custom-8-65536-ext"
}

output "ip-1" {
    value = "${module.1.ip}"
}

output "ip-2" {
    value = "${module.2.ip}"
}

provider "google" {
 project = "${var.project_name}"
 region  = "us-west1"
 zone    = "us-west1b"
}

module "1" {
    source = "./gcp-node"

    name = "node-1"
    ssh_key = "${var.ssh_key}"
    machine_type = "${var.machine_type}"
}

module "2" {
    source = "./gcp-node"

    name = "node-2"
    ssh_key = "${var.ssh_key}"
    machine_type = "${var.machine_type}"
}
