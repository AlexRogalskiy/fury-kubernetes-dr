resource "google_service_account" "velero" {
  project      = "${var.project}"
  account_id   = "${var.cluster_name}-velero"
  display_name = "Velero account for ${var.cluster_name}"
}

resource "google_service_account_key" "velero" {
  service_account_id = "${google_service_account.velero.name}"
}