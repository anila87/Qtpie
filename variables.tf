variable "project_id" {
  description = "GCP Project ID"
  type        = string
}
variable "bucket_name" {
  description = "Storage bucket name"
  type        = string
  default     = "my-project-bucket"
}

variable "vpc_name" {
  description = "VPC network name"
  type        = string
  default     = "my-vpc-network"
}

variable "artifact_repo_name" {
  description = "Artifact Registry repository ID"
  type        = string
  default     = "my-docker-repo"
}

variable "workspace_groups" {
  description = "Google Workspace groups with role-based members"
  type = map(object({
    name        = string
    description = string
    members     = map(list(string)) # role => list of members
  }))
  default = {
    "bucket-group@bil.io" = {
      name        = "Bucket Group"
      description = "Group for Bucket IAM roles"
      members = {
        read              = ["user:aa@bil.io", "user:ana@bil.io"]
        read_write_delete = ["user:aa@bil.io"]
        compliance_read   = ["user:aa@bil.io"]
        full_access       = ["user:aa@bil.io"]
      }
    }
    "vpc-group@bil.io" = {
      name        = "VPC Group"
      description = "Group for VPC IAM roles"
      members = {
        read              = ["user:aa@bil.io"]
        read_write_delete = ["user:aa@bil.io"]
        compliance_read   = ["user:aa@bil.io", "user:ana@bil.io"]
        full_access       = ["user:aa@bil.io"]
      }
    }
    "artifact-group@bil.io" = {
      name        = "Artifact Group"
      description = "Group for Artifact Registry IAM roles"
      members = {
        read              = ["user:aa@bil.io"]
        read_write_delete = ["user:aa@bil.io"]
        compliance_read   = ["user:aa@bil.io", "user:ana@bil.io"]
        full_access       = ["user:aa@bil.io"]
      }
    }
    "iam-group@bil.io" = {
      name        = "IAM Group"
      description = "Group for IAM Admins"
      members = {
        full_access = ["user:aa@bil.io"]
      }
    }
  }
}
