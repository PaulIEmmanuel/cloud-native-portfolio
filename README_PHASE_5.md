# Phase 5 – CI/CD Pipeline (GitHub Actions & Amazon ECR)

## Objective

Introduce a secure, automated Continuous Integration (CI) pipeline that builds and publishes container images for the portfolio backend without manual intervention, following cloud-native and DevOps best practices.

This phase focuses on image build and distribution, not automated deployment.

## Architecture
[Phase 5 Architecture](diagrams/phase-5-architecture.png)

## CI/CD Pipeline Architecture
[Phase 5 Architecture](diagrams/phase-5-architecture2.png)

## AWS Services Used

- **Amazon ECR** – Container image registry  
- **AWS IAM** – OIDC-based role assumption and least-privilege access  
- **GitHub Actions** – CI pipeline execution  
- **Terraform** – Infrastructure as Code for AWS resources  

## CI Pipeline Implementation

### GitHub Actions Workflow

The CI workflow performs the following steps:

- Checks out the repository  
- Authenticates to AWS using OIDC (no static credentials)  
- Logs in to Amazon ECR  
- Builds the Docker image for the backend service  
- Pushes the image to ECR using the latest tag  

The pipeline runs automatically on pushes to the main branch.

## Security Design

### OIDC Authentication (No Long-Lived Credentials)

Instead of storing AWS access keys in GitHub secrets, the pipeline uses:

- An AWS IAM OIDC provider  
- A dedicated GitHub Actions IAM role  
- Short-lived credentials issued per workflow run  

This eliminates credential leakage risk and aligns with modern cloud security standards.

## Deployment Strategy

At this stage, deployment is intentionally manual.

- EC2 instances are not automatically updated on image push  
- New images are pulled and deployed through controlled operational steps  
- Terraform remains the source of truth for infrastructure  

This mirrors real-world environments where CI and CD are separated for stability and control.

## Outcomes

- Fully automated container image build process  
- Secure, auditable AWS authentication for CI  
- Docker images centrally stored in Amazon ECR  
- Foundation laid for automated deployment and monitoring in later phases  

## Next Phase

### Phase 6 – Automation & Monitoring

The next phase will introduce:

- CloudWatch logging and alarms  
- Session Manager access (removing SSH)  
- Deployment automation options  
- Operational observability for the backend service  
