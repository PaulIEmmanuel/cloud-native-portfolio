# Phase 4 – Infrastructure as Code & IAM Hardening

## Objective
This phase transitioned the project from console-managed AWS resources to
Terraform-managed infrastructure while enforcing AWS security best practices.

The focus was on:
- Importing existing AWS resources into Terraform
- Eliminating static AWS credentials from EC2
- Implementing IAM role-based access to DynamoDB
- Hardening infrastructure against accidental destruction

---

## Key Changes

### 1. Terraform Import of Existing Resources
Existing AWS resources were **not recreated**. Instead, they were imported into Terraform state:

- EC2 instance
- DynamoDB table
- Security group

This ensured:
- Zero downtime
- No data loss
- Terraform state reflects real infrastructure

---

### 2. IAM Role-Based Access (No Access Keys)
The EC2 instance now uses:
- An IAM Role
- An Instance Profile
- A least-privilege IAM policy

The role allows:
- `dynamodb:PutItem` on the PortfolioMessages table only

This removes the need for:
- Hardcoded AWS credentials
- `.env` secrets on EC2

---

### 3. Security Group Hardening
SSH access is restricted to a single administrator IP (`/32`).
HTTPS (443) remains publicly accessible.

This follows the principle of **minimum exposure**.

---

### 4. Lifecycle Protection
Terraform lifecycle rules were added to prevent accidental EC2 deletion:

```hcl
lifecycle {
  prevent_destroy = true
}

