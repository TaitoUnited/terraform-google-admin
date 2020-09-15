# Google Cloud administration

Example usage:

```
provider "google" {
  project = "my-infrastructure"
  region  = "europe-west1"
  zone    = "europe-west1b"
}

module "admin" {
  source           = "TaitoUnited/admin/google"
  version          = "1.0.0"
  providers        = [ google ]

  apis             = yamldecode(file("${path.root}/../infra.yaml"))["apis"]
  permissions      = yamldecode(file("${path.root}/../infra.yaml"))["permissions"]["zone"]
  service_accounts = yamldecode(file("${path.root}/../infra.yaml"))["serviceAccounts"]
}
```

Example YAML:

```
apis:
  - id: "cloudbuild.googleapis.com"
  - id: "cloudkms.googleapis.com"
  - id: "compute.googleapis.com"
  - id: "container.googleapis.com"
  - id: "containerregistry.googleapis.com"
  - id: "monitoring.googleapis.com"
  - id: "pubsub.googleapis.com"
  - id: "servicenetworking.googleapis.com"
  - id: "sql-component.googleapis.com"
  - id: "sqladmin.googleapis.com"

serviceAccounts:
  - id: "database-proxy"
  - id: "cicd-tester"
  - id: "my-kms-viewer"
    # TODO: implement roles with google_project_iam_member
    roles: [ "roles/cloudkms.publicKeyViewer" ]

# TODO: custom roles
members:
  - id: "group:devops@mydomain.com"
    roles: [ "roles/owner" ]
  - id: "group:developers@mydomain.com"
    roles: [ "custom/developer" ]
  - id: "user:jane.external@anotherdomain.com"
    roles: [ "custom/limitedDeveloper" ]
  - id: "user:jane.external@anotherdomain.com"
    roles: [ "custom/limitedDataViewer" ]
```

Combine with the following modules to get a complete infrastructure defined by YAML:

- [Admin](https://registry.terraform.io/modules/TaitoUnited/admin/google)
- [DNS](https://registry.terraform.io/modules/TaitoUnited/dns/google)
- [Network](https://registry.terraform.io/modules/TaitoUnited/network/google)
- [Kubernetes](https://registry.terraform.io/modules/TaitoUnited/kubernetes/google)
- [Databases](https://registry.terraform.io/modules/TaitoUnited/databases/google)
- [Storage](https://registry.terraform.io/modules/TaitoUnited/storage/google)
- [Monitoring](https://registry.terraform.io/modules/TaitoUnited/monitoring/google)
- [PostgreSQL privileges](https://registry.terraform.io/modules/TaitoUnited/postgresql-privileges/google)
- [MySQL privileges](https://registry.terraform.io/modules/TaitoUnited/mysql-privileges/google)

Similar modules are also available for AWS, Azure, and DigitalOcean. All modules are used by [infrastructure templates](https://taitounited.github.io/taito-cli/templates#infrastructure-templates) of [Taito CLI](https://taitounited.github.io/taito-cli/).

TIP: See also [Google Cloud project resources](https://registry.terraform.io/modules/TaitoUnited/project-resources/google), [Full Stack Helm Chart](https://github.com/TaitoUnited/taito-charts/blob/master/full-stack), and [full-stack-template](https://github.com/TaitoUnited/full-stack-template).

Contributions are welcome!
