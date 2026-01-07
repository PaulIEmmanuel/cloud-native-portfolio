# Phase 2 – Serverless Backend (AWS Lambda)

## Objective
Extend the static portfolio by introducing a serverless backend that processes
user-submitted data using AWS-managed services.

## Architecture
[Phase 2 Architecture](../diagrams/phase-2-architecture.png)

## AWS Services Used
- AWS Lambda (Python)
- Amazon API Gateway (HTTP API)
- Amazon DynamoDB
- AWS IAM

## Implementation Overview
- Created a DynamoDB table to store contact messages.
- Developed a Python-based AWS Lambda function to process incoming requests.
- Configured an HTTP API Gateway endpoint to invoke the Lambda function.
- Implemented CORS configuration to allow browser-based access from the S3-hosted frontend.
- Used IAM execution roles to grant Lambda least-privilege access to DynamoDB.

## Security Considerations
- No AWS credentials were exposed in frontend code.
- Lambda accessed DynamoDB using an IAM execution role.
- API Gateway handled CORS at the gateway level.

## Outcome
The portfolio now includes a fully functional serverless backend capable of
handling user input and persisting data in a managed NoSQL database.

## Next Phase
Phase 3 will introduce containerization using Docker and a traditional
three-tier architecture with compute and database services.
