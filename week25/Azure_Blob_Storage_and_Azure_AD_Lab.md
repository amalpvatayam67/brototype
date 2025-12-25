# Azure Hands-On Lab: Blob Storage & Azure Active Directory (Azure AD)

## Objective

This lab focuses on understanding and implementing **Azure Blob
Storage** for unstructured data and **Azure Active Directory (Azure
AD)** for identity, authentication, and access control. You will also
demonstrate **Role-Based Access Control (RBAC)** to securely manage
Azure resources.

---

## Part A: Understanding Azure Blob Storage & Azure AD

### Azure Blob Storage -- Concept & Use Cases

**What it is:**\
Azure Blob Storage is an object storage service optimized for storing
massive amounts of unstructured data.

**Common Use Cases:** - Images, videos, and media files - Application
logs and backups - Static website hosting - Data lakes and analytics
workloads

---

### Azure Active Directory (Azure AD) -- Concept & Use Cases

**What it is:**\
Azure AD is Microsoft's cloud-based identity and access management
service.

**Common Use Cases:** - User authentication and Single Sign-On (SSO) -
Application access control - Role-Based Access Control (RBAC) -
Enterprise identity management

---

## Part B: Create and Configure Azure Blob Storage

### Step 1: Create a Storage Account

1.  Go to **Azure Portal → Storage Accounts → Create**
2.  Configure:
    - **Resource Group:** `rg-storage-lab`
    - **Storage Account Name:** `blobstoragelab123`
    - **Region:** Nearest region
    - **Performance:** Standard
    - **Redundancy:** LRS
3.  Click **Review + Create**

---

### Step 2: Create a Blob Container

1.  Open the Storage Account
2.  Navigate to **Containers → + Container**
3.  Set:
    - **Name:** `app-data`
    - **Public Access Level:** Private
4.  Create the container

---

### Step 3: Upload Unstructured Data

- Upload images, text files, or log files into the container
- Verify successful upload via Azure Portal

---

## Part C: Configure Permissions & Access Tiers

### Access Tiers

Tier Description Use Case

---

Hot Frequent access Active app data
Cool Infrequent access Backups
Archive Rare access Compliance data

Set access tier: - Go to **Blob → Properties → Access Tier** - Choose
**Hot / Cool / Archive**

---

### Access Permissions

- Use **Azure RBAC** instead of public access
- Assign roles such as:
  - **Storage Blob Data Reader**
  - **Storage Blob Data Contributor**
  - **Storage Blob Data Owner**

---

## Part D: Set Up Azure Active Directory (Azure AD)

### Step 1: Create Users

1.  Go to **Azure Active Directory → Users → New User**
2.  Create users:
    - `storage-admin`
    - `storage-user`

---

### Step 2: Create Groups (Optional but Recommended)

1.  Go to **Azure AD → Groups → New Group**
2.  Group Name: `BlobStorageTeam`
3.  Add users to the group

---

## Part E: Demonstrate Role-Based Access Control (RBAC)

### Step 1: Assign RBAC Roles

1.  Open **Storage Account → Access Control (IAM)**
2.  Add Role Assignment:
    - **Role:** Storage Blob Data Contributor
    - **Assign Access To:** User / Group
    - **Select:** `BlobStorageTeam`

---

### Step 2: Validate Access Control

- Login as `storage-user`
- Attempt to:
  - Upload blob → Allowed
  - Delete storage account → Denied

This demonstrates **least privilege access**.

---

## Security Best Practices

- Disable public blob access
- Use Azure AD authentication instead of access keys
- Apply RBAC at minimum required scope
- Monitor access using Azure Monitor & Logs

---

## Conclusion

This lab demonstrates how Azure Blob Storage and Azure AD integrate to
provide secure, scalable storage and identity management. RBAC ensures
that users have only the permissions they need, improving overall cloud
security.

---
