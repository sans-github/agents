---
name: terraform
description: Terraform IaC conventions covering module structure, parameterization, state management, IAM, secrets, and security groups. Use when writing, reviewing, or approving infrastructure-as-code changes.
---

# Terraform Standards

## Module structure

Split resources into focused modules by concern. Each module uses the standard HashiCorp file layout:

```
infra/
├── modules/
│   ├── network/
│   │   ├── terraform.tf   # version requirements
│   │   ├── providers.tf   # provider configurations
│   │   ├── main.tf        # primary resources and data sources
│   │   ├── variables.tf   # input variable declarations
│   │   ├── outputs.tf     # output value declarations
│   │   └── locals.tf      # local value declarations
│   ├── compute/
│   └── security/
└── environments/
    ├── dev/
    └── prod/
```

| File | Purpose |
|---|---|
| `terraform.tf` | Terraform version + required providers |
| `providers.tf` | Provider configurations |
| `main.tf` | Primary resources and data sources |
| `variables.tf` | Input variable declarations |
| `outputs.tf` | Output value declarations |
| `locals.tf` | Local value declarations |

---

## Parameterize everything

No hardcoded values -- regions, ports, instance types, and names all go in `variables.tf`:

```hcl
variable "instance_type" {
  description = "EC2 instance type for the app server"
  type        = string
  default     = "t3.medium"
}
```

---

## Output contracts

Expose useful outputs (IPs, ARNs, DNS names) via `outputs.tf` so modules compose cleanly:

```hcl
output "db_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.main.endpoint
}
```

---

## Provider and version pinning

Version requirements go in `terraform.tf`, provider config goes in `providers.tf`. Always pin both to avoid surprise upgrades.

```hcl
# terraform.tf
terraform {
  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
```

```hcl
# providers.tf
provider "aws" {
  region = var.region
}
```

---

## Naming and tagging

Use `var.project`-`var.env` prefixes on all resource names. Tag every resource with at minimum:

```hcl
tags = {
  project    = var.project
  env        = var.env
  managed-by = "terraform"
}
```

---

## Remote state

Use S3 + DynamoDB lock for any shared or production state. Never commit `.tfstate` files.

```hcl
terraform {
  backend "s3" {
    bucket         = "my-project-tfstate"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

---

## IAM -- least privilege

Scope IAM policies to specific actions and resources. No `*` wildcards unless unavoidable and explicitly documented with a justification comment.

```hcl
# Bad
actions   = ["s3:*"]
resources = ["*"]

# Good
actions   = ["s3:GetObject", "s3:PutObject"]
resources = ["arn:aws:s3:::my-bucket/*"]
```

---

## Sensitive variables

Mark secrets with `sensitive = true`. Never set a default. Source values from SSM Parameter Store or Secrets Manager -- never hardcode.

```hcl
variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}
```

---

## Security groups

Explicit ingress and egress rules only. No `0.0.0.0/0` on SSH or admin ports. Prefer referencing security group IDs over CIDR blocks for internal traffic.

```hcl
# Bad -- open SSH to the world
ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Good -- SSH only from bastion SG
ingress {
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  security_groups = [aws_security_group.bastion.id]
}
```

---

## Before applying

Run these four steps in order every time:

```bash
terraform fmt -recursive   # format all files consistently
terraform validate         # catch syntax and reference errors
terraform plan             # review what will change
terraform apply            # make it so
```

Never skip steps. Never apply without a reviewed plan. Include the `terraform plan` resource summary in the commit body for any resource-affecting change.
