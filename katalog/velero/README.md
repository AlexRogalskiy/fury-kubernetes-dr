# Velero

![Velero Logo](../../docs/assets/velero.png)

- [Velero](#velero)
  - [Requirements](#requirements)
  - [Server deployment](#server-deployment)
    - [Velero on premises](#velero-on-premises)
    - [Velero in AWS](#velero-in-aws)
    - [Velero in GCP](#velero-in-gcp)
    - [Velero in Azure](#velero-in-azure)
    - [Velero Restic](#velero-restic)

___

Velero *(formerly Heptio Ark)* gives you tools to back up and restore your Kubernetes cluster resources and persistent
volumes. You can run Velero with a cloud provider or on-premises. Velero lets you:

- Take backups of your cluster and restore in case of loss.
- Migrate cluster resources to other clusters.
- Replicate your production cluster to development and testing clusters.

Velero consists of:

- A server that runs on your cluster
- A command-line client that runs locally


## Requirements

Velero requires to have already deployed the [prometheus-operator](https://github.com/coreos/prometheus-operator) CRDs
as this feature deploys [a `ServiceMonitor` definition](velero-base/serviceMonitor.yaml). It can be deployed using the 
[fury-kubernetes-monitoring](https://github.com/sighupio/fury-kubernetes-monitoring) KFD core module.


## Server deployment

Every velero deployment, does not matter if is on premises or in any of the supported cloud has preconfigured an
[schedule](velero-base/schedule.yaml) to backup all cluster manifests in an object storage. The backup is triggered
every 15 minutes.


### Velero on premises

The [velero-prem](./velero-prem/) feature deploys a [MinIO](https://min.io/) instance in the same cluster as 
object storage backend that Velero can use to store backup data.

*Example `kustomization.yaml` file*

```yaml
namespace: kube-system

bases:
  - katalog/velero/velero-prem
```

### Velero in AWS

The AWS deployment alternative requires to have created `cloud-credentials` secret in the `kube-system` namespace.
You can find a [terraform module](../../modules/aws-velero) designed to create all necessary cloud resources
to make velero works in AWS.

You can find and example terraform project using the [aws-velero](../../modules/aws-velero) terraform module
[here](../../example/aws-example/main.tf)

```bash
$ cd example/aws-example
$ terraform init
$ terraform apply --var="my_cluster_name=kubernetes-cluster-and-velero"
$ terraform output cloud_credentials > /tmp/cloud_credentials.config
$ terraform output volume_snapshot_location > /tmp/volume_snapshot_location.yaml
$ terraform output backup_storage_location > /tmp/backup_storage_location.yaml
$ kubectl apply -f /tmp/cloud_credentials.config -n kube-system
$ kubectl apply -f /tmp/volume_snapshot_location.yaml -n kube-system
$ kubectl apply -f /tmp/backup_storage_location.yaml -n kube-system
```

Then, you will be able to deploy the velero AWS deployment.

*Example `kustomization.yaml` file*

```yaml
namespace: kube-system

bases:
  - katalog/velero/velero-aws
```

More information about the [AWS Velero Plugin](https://github.com/vmware-tanzu/velero-plugin-for-aws)


### Velero in GCP

The GCP deployment alternative requires to have created `cloud-credentials` secret in the `kube-system` namespace.
You can find a [terraform module](../../modules/gcp-velero) designed to create all necessary cloud resources
to make velero works in GCP.

Then, you will be able to deploy the velero GCP deployment.

*Example `kustomization.yaml` file*

```yaml
namespace: kube-system

bases:
  - katalog/velero/velero-gcp
```

More information about the [GCP Velero Plugin](https://github.com/vmware-tanzu/velero-plugin-for-gcp)


### Velero in Azure

The Azure deployment alternative requires to have created `cloud-credentials` secret in the `kube-system` namespace.
You can find a [terraform module](../../modules/azure-velero) designed to create all necessary cloud resources
to make velero works in Azure.

Then, you will be able to deploy the velero Azure deployment.

*Example `kustomization.yaml` file*

```yaml
namespace: kube-system

bases:
  - katalog/velero/velero-azure
```

More information about the [Azure Velero Plugin](https://github.com/vmware-tanzu/velero-plugin-for-microsoft-azure)


### Velero Restic

Velero has support for backing up and restoring Kubernetes volumes using a free open-source backup tool called restic.

[velero-restic](./velero-restic) requires to have a velero deployment running in the cluster before deploy it.
Velero restic is not tied to be deployed on prem or on cloud. So feel free to deploy it with your prefered velero
deployment.

```yaml
namespace: kube-system

bases:
  - katalog/velero/velero-aws
  - katalog/velero/velero-restic
```

More information about [Velero Restic integration](https://velero.io/docs/v1.2.0/restic/)