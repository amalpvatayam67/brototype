
# AWS Core Services – Study & Practical Overview

## Objective
This document provides an in-depth understanding and practical exposure to essential AWS services, their purposes, functionality, key use cases, and how they integrate within a modern cloud infrastructure.

---

## 1. Amazon EC2 (Elastic Compute Cloud)
**Purpose:** Virtual servers for running applications.

**Functionality:**
- Provides resizable compute capacity
- Supports multiple OS (Linux, Windows)
- Integrated with Auto Scaling and Load Balancers

**Key Use Cases:**
- Hosting web applications
- Backend APIs
- Batch processing

---

## 2. Amazon ECS (Elastic Container Service)
**Purpose:** Container orchestration service for Docker containers.

**Functionality:**
- Runs containers on EC2 or AWS Fargate
- Task definitions and services
- Native AWS integration

**Key Use Cases:**
- Microservices deployment
- Containerized APIs
- CI/CD pipelines

---

## 3. Amazon EKS (Elastic Kubernetes Service)
**Purpose:** Managed Kubernetes service.

**Functionality:**
- Runs Kubernetes control plane
- Integrates with IAM and VPC
- Supports Kubernetes-native tools

**Key Use Cases:**
- Large-scale container orchestration
- Cloud-native applications
- Hybrid and multi-cloud workloads

---

## 4. Amazon VPC (Virtual Private Cloud)
**Purpose:** Isolated virtual network in AWS.

**Functionality:**
- Subnets (public/private)
- Route tables, NAT, Internet Gateway
- Network ACLs

**Key Use Cases:**
- Secure network segmentation
- Multi-tier architectures
- Hybrid cloud connectivity

---

## 5. Security Groups
**Purpose:** Virtual firewall for AWS resources.

**Functionality:**
- Stateful rules
- Inbound and outbound traffic control
- Attached to EC2, ALB, RDS, etc.

**Key Use Cases:**
- Network-level security
- Restricting access to services

---

## 6. Amazon Route 53
**Purpose:** DNS and domain management service.

**Functionality:**
- Domain registration
- DNS routing policies
- Health checks

**Key Use Cases:**
- Domain-to-application routing
- Failover and latency-based routing

---

## 7. Elastic Load Balancer (ALB / NLB)
**Purpose:** Distributes traffic across multiple targets.

**Functionality:**
- Layer 7 (ALB) and Layer 4 (NLB)
- Health checks
- SSL termination

**Key Use Cases:**
- High availability
- Traffic distribution
- Zero-downtime deployments

---

## 8. Amazon S3 (Simple Storage Service)
**Purpose:** Object storage service.

**Functionality:**
- Stores files as objects
- Versioning and lifecycle rules
- Static website hosting

**Key Use Cases:**
- File storage
- Backups
- Static assets and logs

---

## 9. AWS WAF (Web Application Firewall)
**Purpose:** Protects applications from web exploits.

**Functionality:**
- Rules for SQLi, XSS
- IP-based blocking
- Integration with ALB, CloudFront

**Key Use Cases:**
- Web attack mitigation
- API protection
- Compliance enforcement

---

## 10. Amazon Athena
**Purpose:** Serverless SQL query service for S3 data.

**Functionality:**
- Uses standard SQL
- No infrastructure management
- Integrates with Glue Data Catalog

**Key Use Cases:**
- Log analysis
- Security analytics
- Data exploration

---

## 11. AWS IAM (Identity and Access Management)
**Purpose:** Controls access to AWS resources.

**Functionality:**
- Users, roles, policies
- Least privilege enforcement
- Temporary credentials

**Key Use Cases:**
- Secure access management
- Service-to-service authentication

---

## 12. AWS Lambda
**Purpose:** Serverless compute service.

**Functionality:**
- Event-driven execution
- Automatic scaling
- Pay-per-execution

**Key Use Cases:**
- API backends
- Automation scripts
- Event processing

---

## How These Services Work Together (Architecture Flow)

1. **Route 53** routes traffic to **Load Balancer**
2. **Load Balancer** forwards requests to **EC2 / ECS / EKS**
3. **Security Groups** control traffic at instance and service level
4. **VPC** provides isolated networking
5. **IAM** manages permissions for users and services
6. **S3** stores static assets, logs, and backups
7. **Lambda** processes events and automates workflows
8. **WAF** protects applications from attacks
9. **Athena** analyzes logs stored in S3

---

## Conclusion
These AWS services together form a secure, scalable, and highly available cloud infrastructure suitable for modern application architectures, including microservices, serverless, and data-driven systems.
