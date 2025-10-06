# GCP Infrastructure & Access Management Automation

# Overview

This Terraform project provides a robust, scalable foundation for managing Google Cloud resources and access control. It automates the creation of key resources while enforcing fine-grained, role-based permissions, ensuring security, governance, and operational efficiency.

# Resources Managed

The project provisions essential GCP resources required for most cloud workloads:

Storage Buckets – for object storage and data management

VPC Networks – secure, isolated network infrastructure

Artifact Registries – to store and manage container images and artifacts

Cloud Run Services – serverless containerized applications

Cloud Functions – event-driven serverless functions

# Custom IAM Roles

Each resource is associated with four custom IAM roles, designed for precise access control:

Read – view-only access

Read_Write_Delete – operational control with create, update, and delete permissions

Compliance_Read – access for auditing and policy review

Full_Access – complete control, including policy management

IAM Admin has a dedicated Full Access role for overall governance.

# Groups and Memberships

Workspace groups mirror the roles, ensuring users are assigned permissions appropriately.

Dynamic group creation – all groups are automatically provisioned based on variables.

Membership mapping – members are assigned to roles per resource without manual intervention.

Automatic IAM bindings – all permissions are applied to the right groups seamlessly.

# Modular Structure

The project is organized into three key files:

main.tf – defines GCP resources and custom IAM roles

variables.tf – manages project IDs, group memberships, and role assignments

groups.tf – handles group creation, memberships, and IAM bindings

This modular approach allows easy updates, extensions, and clear separation of responsibilities.
