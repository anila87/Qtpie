#Bucketroles
resource "google_project_iam_custom_role" "bucket_viewer" {
  role_id     = "bucketViewer"
  title       = "Bucket Viewer"
  description = "View access to Cloud Storage Buckets"
  project     = var.project_id
  permissions = [
    "storage.buckets.get",
    "storage.buckets.list",
    "storage.objects.get",
    "storage.objects.list"
  ]
  stage = "GA"
}

resource "google_project_iam_custom_role" "bucket_editor" {
  role_id     = "bucketEditor"
  title       = "Bucket Editor"
  description = "Edit access to Cloud Storage Buckets"
  project     = var.project_id
  permissions = [
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.update"
  ]
  stage = "GA"
}

resource "google_project_iam_custom_role" "bucket_auditor" {
  role_id     = "bucketAuditor"
  title       = "Bucket Auditor"
  description = "Audit access to Cloud Storage Buckets"
  project     = var.project_id
  permissions = [
    "storage.buckets.getIamPolicy",
    "storage.objects.getIamPolicy"
  ]
  stage = "GA"
}

resource "google_project_iam_custom_role" "bucket_admin" {
  role_id     = "bucketAdmin"
  title       = "Bucket Admin"
  description = "Full access to Cloud Storage Buckets"
  project     = var.project_id
  permissions = [
    "storage.buckets.get",
    "storage.buckets.list",
    "storage.buckets.create",
    "storage.buckets.delete",
    "storage.objects.get",
    "storage.objects.list",
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.update",
    "storage.buckets.getIamPolicy",
    "storage.buckets.setIamPolicy",
    "storage.objects.getIamPolicy",
    "storage.objects.setIamPolicy"
  ]
  stage = "GA"
}

# Bucket Bindings
resource "google_project_iam_binding" "bucket_viewer_binding" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/bucketViewer"
  members = ["group:bucket-group@bil.io"]
}

resource "google_project_iam_binding" "bucket_editor_binding" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/bucketEditor"
  members = ["group:bucket-group@bil.io"]
}

resource "google_project_iam_binding" "bucket_auditor_binding" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/bucketAuditor"
  members = ["group:bucket-group@bil.io"]
}

resource "google_project_iam_binding" "bucket_admin_binding" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/bucketAdmin"
  members = ["group:bucket-group@bil.io"]
}

# VPC Roles
resource "google_project_iam_custom_role" "vpc_viewer" {
  role_id     = "vpcViewer"
  title       = "VPC Viewer"
  description = "View access to VPC"
  project     = var.project_id
  permissions = ["compute.networks.get", "compute.subnetworks.get"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "vpc_editor" {
  role_id     = "vpcEditor"
  title       = "VPC Editor"
  description = "Edit access to VPC"
  project     = var.project_id
  permissions = ["compute.networks.update", "compute.subnetworks.update"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "vpc_auditor" {
  role_id     = "vpcAuditor"
  title       = "VPC Auditor"
  description = "Audit access to VPC"
  project     = var.project_id
  permissions = ["compute.networks.getIamPolicy", "compute.subnetworks.getIamPolicy"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "vpc_admin" {
  role_id     = "vpcAdmin"
  title       = "VPC Admin"
  description = "Full access to VPC"
  project     = var.project_id
  permissions = [
    "compute.networks.get",
    "compute.networks.list",
    "compute.networks.create",
    "compute.networks.delete",
    "compute.networks.update",
    "compute.networks.getIamPolicy",
    "compute.networks.setIamPolicy",
    "compute.subnetworks.get",
    "compute.subnetworks.list",
    "compute.subnetworks.create",
    "compute.subnetworks.delete",
    "compute.subnetworks.update",
    "compute.subnetworks.getIamPolicy",
    "compute.subnetworks.setIamPolicy"
  ]
  stage = "GA"
}

# VPC Bindings
resource "google_project_iam_binding" "vpc_viewer_binding" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/vpcViewer"
  members = ["group:vpc-group@bil.io"]
}

resource "google_project_iam_binding" "vpc_editor_binding" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/vpcEditor"
  members = ["group:vpc-group@bil.io"]
}

resource "google_project_iam_binding" "vpc_auditor_binding" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/vpcAuditor"
  members = ["group:vpc-group@bil.io"]
}

resource "google_project_iam_binding" "vpc_admin_binding" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/vpcAdmin"
  members = ["group:vpc-group@bil.io"]
}

# Artifact Roles
resource "google_project_iam_custom_role" "artifact_viewer" {
  role_id     = "artifactViewer"
  title       = "Artifact Viewer"
  description = "View access to Artifact Registry"
  project     = var.project_id
  permissions = ["artifactregistry.repositories.get", "artifactregistry.versions.list"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "artifact_editor" {
  role_id     = "artifactEditor"
  title       = "Artifact Editor"
  description = "Edit access to Artifact Registry"
  project     = var.project_id
  permissions = ["artifactregistry.versions.delete"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "artifact_auditor" {
  role_id     = "artifactAuditor"
  title       = "Artifact Auditor"
  description = "Audit access to Artifact Registry"
  project     = var.project_id
  permissions = ["artifactregistry.repositories.getIamPolicy"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "artifact_admin" {
  role_id     = "artifactAdmin"
  title       = "Artifact Admin"
  description = "Full access to Artifact Registry"
  project     = var.project_id
  permissions = [
    "artifactregistry.repositories.get",
    "artifactregistry.repositories.list",
    "artifactregistry.repositories.create",
    "artifactregistry.repositories.delete",
    "artifactregistry.versions.get",
    "artifactregistry.versions.list",
    "artifactregistry.versions.delete",
    "artifactregistry.repositories.getIamPolicy",
    "artifactregistry.repositories.setIamPolicy"
  ]
  stage = "GA"
}

# Artifact Bindings
resource "google_project_iam_binding" "artifact_viewer_binding" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/artifactViewer"
  members = ["group:artifact-group@bil.io"]
}

resource "google_project_iam_binding" "artifact_editor_binding" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/artifactEditor"
  members = ["group:artifact-group@bil.io"]
}

resource "google_project_iam_binding" "artifact_auditor_binding" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/artifactAuditor"
  members = ["group:artifact-group@bil.io"]
}

resource "google_project_iam_binding" "artifact_admin_binding" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/artifactAdmin"
  members = ["group:artifact-group@bil.io"]
}

# IAM Role
resource "google_project_iam_custom_role" "iam_admin" {
  role_id     = "iamAdmin"
  title       = "IAM Admin"
  description = "Manage IAM policies and roles"
  project     = var.project_id
  permissions = [
    "iam.roles.create",
    "iam.roles.delete",
    "resourcemanager.projects.setIamPolicy"
  ]
  stage = "GA"
}

# IAM Binding
resource "google_project_iam_binding" "iam_admin_binding" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/iamAdmin"
  members = ["group:iam-group@bil.io"]
}


