# Phase 6 – Monitoring, Observability, and Reliability Automation

## Overview

This phase adds production-grade monitoring, logging, alerting, and automated recovery to the Cloud-Native Portfolio Platform.

By the end of Phase 6, the application:

- exposes a `/health` endpoint
- logs application activity centrally
- streams metrics and logs to CloudWatch
- auto-restarts containers on failure
- supports EC2 automatic recovery
- provides dashboards and alarms
- supports Systems Manager Session Manager access (no SSH keys)

This phase converts the project from working software to an operational service.

---

## Architecture Summary

Phase 6 builds on:

- Phase 1 – S3 static frontend
- Phase 2 – Serverless backend introduction
- Phase 3 – Dockerized backend on EC2
- Phase 5 – CI/CD with GitHub Actions and ECR

Additional services introduced:

- CloudWatch Logs
- CloudWatch Metrics
- CloudWatch Dashboards
- CloudWatch Alarms
- IAM Roles for CloudWatch + ECR pulling
- AWS Systems Manager (Session Manager)
- Docker restart policy automation

EC2 now sends:

- host metrics
- container logs
- application logs to Amazon CloudWatch.

---

## Objectives

The goals of Phase 6 are:

- centralize observability
- detect failures early
- reduce downtime
- create dashboards useful for interviews
- demonstrate real-world DevOps operations

---

## Step 1 – Application Logging Added

The backend Flask app was updated to include:

- health route `/health`
- structured logging with timestamps
- logging for successful and failed operations
- INFO and ERROR levels

Logs now flow to:

- Docker stdout
- CloudWatch Logs (via agent)

---

## Step 2 – CloudWatch Agent Installed on EC2

The CloudWatch agent was installed and enabled as a service.

It collects:

- CPU utilization
- memory utilization
- disk usage
- network I/O
- Docker container metrics
- application log streams

The service was verified using:

```
sudo systemctl status amazon-cloudwatch-agent
```

---

## Step 3 – CloudWatch Dashboard Created

The dashboard includes:

- EC2 CPU usage graph
- memory utilization graph
- disk utilization graph
- log insights query results (API errors, 5xx, etc.)
- application log streams
- text description widgets

This dashboard demonstrates live platform state.

---

## Step 4 – CloudWatch Alarms Configured

Alarms were added for:

- EC2 CPU > 80% sustained threshold
- EC2 instance status check failed
- missing log data
- HTTP 5xx pattern in logs

Optional alarm targets:

- email via SNS
- EC2 automatic recovery
- Slack or webhook destinations

---

## Step 5 – Reliability & Auto-Recovery Added

### Docker Restart Policy

Container now runs with:

```
--restart unless-stopped
```

Outcome:

- container returns automatically on crash
- container restarts on reboot
- does not auto-start after deliberate manual stop

### EC2 Auto-Recovery Enabled

Automatic host recovery is configured for hardware failure.

### Session Manager Access

This allows connection without SSH keys:

- no port 22 required
- fully audited sessions
- security best practice

---

## Step 6 – Health Check Endpoint

The backend exposes:

`GET /health`

Returns:

```
{"status":"ok"}
```

Used for:

- uptime monitors
- load balancer health checks
- readiness checks

---




