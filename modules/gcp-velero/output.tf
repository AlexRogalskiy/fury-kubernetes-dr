locals {
  cloud_credentials = <<EOF
TODO
TBD
TODO
EOF

  backup_storage_location  = <<EOF
apiVersion: ark.heptio.com/v1
kind: BackupStorageLocation
metadata:
  name: default
spec:
  provider: gcp
  objectStorage:
    bucket: ${google_storage_bucket.main.name}
    prefix: ${var.bucket_prefix}
EOF
  volume_snapshot_location = <<EOF
apiVersion: ark.heptio.com/v1
kind: VolumeSnapshotLocation
metadata:
  name: default
spec:
  provider: gcp
EOF
}

output "cloud_credentials" {
  value = "${local.cloud_credentials}"
}

output "backup_storage_location" {
  value = "${local.backup_storage_location}"
}

output "volume_snapshot_location" {
  value = "${local.volume_snapshot_location}"
}
