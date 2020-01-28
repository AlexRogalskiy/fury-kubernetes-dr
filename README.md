# fury-kubernetes-dr

This repo contains packages to use in case of Disaster Recovery.

## Disaster Recovery Packages

Following packages are included in Fury Kubernetes Disaster Recovery katalog:

- [velero](katalog/velero): Velero (formerly Heptio Ark) gives you tools to
back up and restore your Kubernetes cluster resources and persistent volumes. Version: **1.0.0**
- [velero-restic](katalog/velero-restic): Velero has support for backing up and restoring
Kubernetes volumes using a free open-source backup tool called restic. Version: **1.0.0**

Following packages are included in Fury Kubernetes Disaster Recovery modules:

- [aws-velero](modules/aws-velero): Creates AWS resources and kubernetes CRDs needed to persist backups.
- [azure-velero](modules/azure-velero): Creates Azure resources and kubernetes CRDs needed to persist backups.
- [gcp-velero](modules/gcp-velero): Creates GCP resources and kubernetes CRDs needed to persist backups.


## Compatibility

| Module Version / Kubernetes Version | 1.14.X             | 1.15.X             | 1.16.X             |
|-------------------------------------|:------------------:|:------------------:|:------------------:|
| v1.0.0                              |                    |                    |                    |
| v1.1.0                              |                    |                    |                    |

- :white_check_mark: Compatible
- :warning: Has issues
- :x: Incompatible
