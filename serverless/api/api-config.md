# API Gateway Configuration – Phase 2

## API Type
HTTP API

## Endpoint
POST /contact

## Purpose
Receives contact form submissions from the portfolio frontend and forwards
the request to an AWS Lambda function for processing and storage.

## Integration
- Integrated with AWS Lambda function: `portfolioMessageHandler`
- Uses AWS-managed integration (Lambda proxy)

## CORS Configuration
- Allow-Origin: *
- Allow-Methods: POST, OPTIONS
- Allow-Headers: Content-Type

## Security
- No authentication (public contact form)
- IAM execution role with least-privilege DynamoDB access

## Deployment Stage
- prod

## Request Format
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "message": "Hello, I viewed your portfolio."
}

