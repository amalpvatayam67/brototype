
# AWS Hands-On Lab: Amazon S3 & IAM (Identity and Access Management)

## Objective
This document covers both **conceptual understanding** and **practical implementation** of:
- Amazon S3 (Storage Service)
- AWS IAM (Identity and Access Management)

It demonstrates how to securely store data in S3 and control access using IAM users, groups, roles, and policies.

---

## A. Understanding AWS S3 and IAM Concepts

### Amazon S3 (Simple Storage Service)
**Purpose:** Object storage service for storing and retrieving any amount of data.

**Key Concepts:**
- **Bucket:** A container for objects (globally unique name)
- **Object:** Data stored in S3 (file + metadata)
- **Key:** Unique identifier for an object
- **Storage Classes:** Standard, IA, Glacier, Deep Archive

**Common Use Cases:**
- Static website hosting
- Application data storage
- Backups and disaster recovery
- Log storage and analytics

---

### AWS IAM (Identity and Access Management)
**Purpose:** Manage access to AWS resources securely.

**Key Concepts:**
- **Users:** Individual identities
- **Groups:** Collection of users with shared permissions
- **Roles:** Temporary access for services or users
- **Policies:** JSON documents defining permissions

**Core Principle:** Least Privilege Access

---

## B. Create and Configure an S3 Bucket

### Steps:
1. Log in to **AWS Management Console**
2. Navigate to **S3 → Create Bucket**
3. Configure bucket:
   - Bucket name: `my-secure-s3-bucket`
   - Region: Choose nearest region
4. Block Public Access:
   - Keep all public access blocked (recommended)
5. Enable options (optional):
   - Versioning
   - Server-side encryption (SSE-S3 or SSE-KMS)
6. Create the bucket

---

## C. Set Permissions and Access Policies for S3

### Bucket Policy Example (Read-only Access):
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "AWS": "arn:aws:iam::ACCOUNT-ID:role/S3ReadRole" },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-secure-s3-bucket/*"
    }
  ]
}
```

### Best Practices:
- Avoid public bucket access
- Use IAM roles instead of access keys
- Enable logging and versioning

---

## D. Set Up IAM Users, Groups, Roles, and Policies

### 1. Create IAM Group
1. Go to **IAM → User Groups → Create Group**
2. Group name: `S3-Admins`
3. Attach policy:
   - `AmazonS3FullAccess` (for lab)

---

### 2. Create IAM User
1. Go to **IAM → Users → Create User**
2. Username: `s3-user`
3. Access type:
   - AWS Management Console
4. Add user to group: `S3-Admins`

---

### 3. Create IAM Role (EC2 Access to S3)
1. Go to **IAM → Roles → Create Role**
2. Trusted entity: **AWS Service**
3. Service: **EC2**
4. Attach policy:
   - `AmazonS3ReadOnlyAccess`
5. Role name: `EC2-S3-ReadRole`

---

## E. Demonstrate Secure Access Using IAM Roles

### Scenario: EC2 Accessing S3 Securely
1. Attach IAM Role `EC2-S3-ReadRole` to EC2 instance
2. SSH into EC2 instance
3. Access S3 without access keys:
```bash
aws s3 ls s3://my-secure-s3-bucket
```

### Result:
- Access is granted using IAM role
- No hardcoded credentials used
- Follows AWS security best practices

---

## Architecture Flow

1. User authenticates via IAM
2. IAM policies determine permissions
3. EC2 assumes IAM role
4. Role grants controlled access to S3
5. S3 enforces bucket and IAM policies

---

## Security Best Practices
- Enable MFA for IAM users
- Rotate credentials regularly
- Use roles instead of access keys
- Monitor access via CloudTrail

---

## Outcome
- Secure S3 bucket configuration
- Controlled access using IAM
- Practical demonstration of least-privilege access
- Foundation for secure AWS architectures
