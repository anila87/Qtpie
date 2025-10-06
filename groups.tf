# ------------------------
# Workspace Groups
# ------------------------
resource "googleworkspace_group" "groups" {
  for_each    = var.workspace_groups
  email       = each.key
  name        = each.value.name
  description = each.value.description
}

# ------------------------
# Group Memberships
# ------------------------
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

# ------------------------
# IAM Bindings
# ------------------------
resource "google_project_iam_binding" "bindings" {
  for_each = {
    for group_email, group_data in var.workspace_groups :
    for role, _ in group_data.members :
    "${group_email}-${role}" => {
      group_email = group_email
      role_name   = title(replace(role, "_", ""))
    }
  }

  project = var.project_id
  role    = "projects/${var.project_id}/roles/${each.value.role_name}"
  members = ["group:${each.value.group_email}"]
}
