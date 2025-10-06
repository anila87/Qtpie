variable "workspace_groups" {
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

resource "googleworkspace_group" "groups" {
  for_each    = var.workspace_groups
  email       = each.key
  name        = each.value.name
  description = each.value.description
}

resource "googleworkspace_group_membership" "group_memberships" {
  for_each = {
    for group_email, group_data in var.workspace_groups :
    for role, members in group_data.members :
    for member in members :
    "${group_email}-${role}-${member}" => {
      group  = group_email
      member = member
    }
  }

  group  = each.value.group
  role   = "MEMBER"
  member = each.value.member
}
