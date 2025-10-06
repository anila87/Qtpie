## Storage Bucket
resource "google_storage_bucket" "my_bucket" {
  name     = "my-project-bucket"
  project  = var.project_id
  location = "US"
}

## VPC Network
resource "google_compute_network" "my_vpc" {
  name                    = "my-vpc-network"
  auto_create_subnetworks = true
}

## Artifact Registry Repo
resource "google_artifact_registry_repository" "my_repo" {
  name         = "my-artifact-repo"
  repository_id = "my-docker-repo"
  format       = "DOCKER"
  location     = "us-central1"
  project      = var.project_id
}
## Cloud Run
resource "google_cloud_run_service" "my_service" {
  name     = "my-cloud-run-service"
  location = "us-central1"
  project  = var.project_id

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }
}
## Cloud Function
resource "google_cloudfunctions_function" "my_function" {
  name        = "my-cloud-function"
  runtime     = "python311"
  entry_point = "hello_world"
  project     = var.project_id
  region      = "us-central1"

  source_archive_bucket = google_storage_bucket.my_bucket.name
  source_archive_object = "function-source.zip"
}
# ------------------------
# Bucket Roles
# ------------------------
resource "google_project_iam_custom_role" "bucket_read" {
  role_id     = "bucketRead"
  title       = "Bucket Read"
  description = "Read access to Cloud Storage Buckets"
  project     = var.project_id
  permissions = [
    "storage.buckets.get",
    "storage.buckets.list",
    "storage.objects.get",
    "storage.objects.list"
  ]
  stage = "GA"
}

resource "google_project_iam_custom_role" "bucket_read_write_delete" {
  role_id     = "bucketReadWriteDelete"
  title       = "Bucket Read Write Delete"
  description = "Read, write, and delete access to Cloud Storage Buckets"
  project     = var.project_id
  permissions = [
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.update"
  ]
  stage = "GA"
}

resource "google_project_iam_custom_role" "bucket_compliance_read" {
  role_id     = "bucketComplianceRead"
  title       = "Bucket Compliance Read"
  description = "Compliance read access to Cloud Storage Buckets"
  project     = var.project_id
  permissions = [
    "storage.buckets.getIamPolicy",
    "storage.objects.getIamPolicy"
  ]
  stage = "GA"
}

resource "google_project_iam_custom_role" "bucket_full_access" {
  role_id     = "bucketFullAccess"
  title       = "Bucket Full Access"
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

# ------------------------
# VPC Roles
# ------------------------
resource "google_project_iam_custom_role" "vpc_read" {
  role_id     = "vpcRead"
  title       = "VPC Read"
  description = "Read access to VPC"
  project     = var.project_id
  permissions = ["compute.networks.get", "compute.subnetworks.get"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "vpc_read_write_delete" {
  role_id     = "vpcReadWriteDelete"
  title       = "VPC Read Write Delete"
  description = "Read, write, and delete access to VPC"
  project     = var.project_id
  permissions = ["compute.networks.update", "compute.subnetworks.update"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "vpc_compliance_read" {
  role_id     = "vpcComplianceRead"
  title       = "VPC Compliance Read"
  description = "Compliance read access to VPC"
  project     = var.project_id
  permissions = ["compute.networks.getIamPolicy", "compute.subnetworks.getIamPolicy"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "vpc_full_access" {
  role_id     = "vpcFullAccess"
  title       = "VPC Full Access"
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

# ------------------------
# Artifact Roles
# ------------------------
resource "google_project_iam_custom_role" "artifact_read" {
  role_id     = "artifactRead"
  title       = "Artifact Read"
  description = "Read access to Artifact Registry"
  project     = var.project_id
  permissions = ["artifactregistry.repositories.get", "artifactregistry.versions.list"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "artifact_read_write_delete" {
  role_id     = "artifactReadWriteDelete"
  title       = "Artifact Read Write Delete"
  description = "Read, write, and delete access to Artifact Registry"
  project     = var.project_id
  permissions = ["artifactregistry.versions.delete"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "artifact_compliance_read" {
  role_id     = "artifactComplianceRead"
  title       = "Artifact Compliance Read"
  description = "Compliance read access to Artifact Registry"
  project     = var.project_id
  permissions = ["artifactregistry.repositories.getIamPolicy"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "artifact_full_access" {
  role_id     = "artifactFullAccess"
  title       = "Artifact Full Access"
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

# ------------------------
# IAM Admin Role
# ------------------------
resource "google_project_iam_custom_role" "iam_full_access" {
  role_id     = "iamFullAccess"
  title       = "IAM Full Access"
  description = "Manage IAM policies and roles"
  project     = var.project_id
  permissions = [
    "iam.roles.create",
    "iam.roles.delete",
    "resourcemanager.projects.setIamPolicy"
  ]
  stage = "GA"
}
# ------------------------
# Cloud Run Roles
# ------------------------
resource "google_project_iam_custom_role" "cloudrun_read" {
  role_id     = "cloudRunRead"
  title       = "Cloud Run Read"
  description = "Read access to Cloud Run services"
  project     = var.project_id
  permissions = ["run.services.get", "run.services.list"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "cloudrun_read_write_delete" {
  role_id     = "cloudRunReadWriteDelete"
  title       = "Cloud Run Read Write Delete"
  description = "Read, update, and delete Cloud Run services"
  project     = var.project_id
  permissions = ["run.services.update", "run.services.delete", "run.services.create"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "cloudrun_compliance_read" {
  role_id     = "cloudRunComplianceRead"
  title       = "Cloud Run Compliance Read"
  description = "Compliance read access to Cloud Run services"
  project     = var.project_id
  permissions = ["run.services.getIamPolicy"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "cloudrun_full_access" {
  role_id     = "cloudRunFullAccess"
  title       = "Cloud Run Full Access"
  description = "Full access to Cloud Run services"
  project     = var.project_id
  permissions = [
    "run.services.get",
    "run.services.list",
    "run.services.create",
    "run.services.update",
    "run.services.delete",
    "run.services.getIamPolicy",
    "run.services.setIamPolicy"
  ]
  stage = "GA"
}

# ------------------------
# Cloud Functions Roles
# ------------------------
resource "google_project_iam_custom_role" "cloudfunc_read" {
  role_id     = "cloudFuncRead"
  title       = "Cloud Function Read"
  description = "Read access to Cloud Functions"
  project     = var.project_id
  permissions = ["cloudfunctions.functions.get", "cloudfunctions.functions.list"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "cloudfunc_read_write_delete" {
  role_id     = "cloudFuncReadWriteDelete"
  title       = "Cloud Function Read Write Delete"
  description = "Read, update, and delete Cloud Functions"
  project     = var.project_id
  permissions = ["cloudfunctions.functions.create", "cloudfunctions.functions.update", "cloudfunctions.functions.delete"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "cloudfunc_compliance_read" {
  role_id     = "cloudFuncComplianceRead"
  title       = "Cloud Function Compliance Read"
  description = "Compliance read for Cloud Functions"
  project     = var.project_id
  permissions = ["cloudfunctions.functions.getIamPolicy"]
  stage       = "GA"
}

resource "google_project_iam_custom_role" "cloudfunc_full_access" {
  role_id     = "cloudFuncFullAccess"
  title       = "Cloud Function Full Access"
  description = "Full access to Cloud Functions"
  project     = var.project_id
  permissions = [
    "cloudfunctions.functions.get",
    "cloudfunctions.functions.list",
    "cloudfunctions.functions.create",
    "cloudfunctions.functions.update",
    "cloudfunctions.functions.delete",
    "cloudfunctions.functions.getIamPolicy",
    "cloudfunctions.functions.setIamPolicy"
  ]
  stage = "GA"
}
