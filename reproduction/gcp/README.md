# Provisioning a GCP pair of instances

## Provisioning

You can either provision the pair of instances through the GCP console, or through [terraform](#Terraform Provisioning).

If you provision manually, once your instance is up, clone this repo (`git clone https://github.com/kevindrosendahl/eval-scripts.git`).

## Setup

Once your instance has been provisioned, run the following:

```bash
$ ~/eval-scrpits/reproduction/gcp/setup.sh
```

## Terraform Provisioning

First, [download terraform](https://releases.hashicorp.com/terraform/). This was originally developed against v0.11.14.

Then, ensure you have [properly set up credentials](https://www.terraform.io/docs/providers/google/getting_started.html#adding-credentials).

Once you've done this, `cd` into the `terraform` directory, and run `terraform init`.

Finally, run

```bash
$ terraform apply \
    -var "project_name=${PROJECT_NAME}" \
    -var 'ssh_key=${PUBLIC_KEY_PATH}'
```

Where `PROEJCT_NAME` is the name of your GCP project and `PUBLIC_KEY_PATH` is a path on your filesystem to a public key you wish to use for ssh.


