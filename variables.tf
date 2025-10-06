variable "project" {
  description = name of the project
}

variable "region" {
  description = name of the region
  default = "us-central1"
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
        viewer  = ["user:aa@bil.io", "user:ana@bil.io"]
        editor  = ["user:aa@bil.io"]
        auditor = ["user:aa@bil.io"]
        admin   = ["user:aa@bil.io"]
      }
    }
    "vpc-group@bil.io" = {
      name        = "VPC Group"
      description = "Group for VPC IAM roles"
      members = {
        viewer  = ["user:aa@bil.io"]
        editor  = ["user:aa@bil.io"]
        auditor = ["user:aa@bil.io", "user:ana@bil.io"]
        admin   = ["user:aa@bil.io"]
      }
    }
    "artifact-group@bil.io" = {
      name        = "Artifact Group"
      description = "Group for Artifact Registry IAM roles"
      members = {
        viewer  = ["user:aa@bil.io"]
        editor  = ["user:aa@bil.io"]
        auditor = ["user:aa@bil.io", "user:ana@bil.io"]
        admin   = ["user:aa@bil.io"]
      }
    }
    "iam-group@bil.io" = {
      name        = "IAM Group"
      description = "Group for IAM Admins"
      members = {
        admin = ["user:aa@bil.io"]
      }
    }
  }
}
