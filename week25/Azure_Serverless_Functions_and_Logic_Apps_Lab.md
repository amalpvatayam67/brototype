# Azure Hands-On Lab: Serverless Computing with Azure Functions & Logic Apps

## Objective

This lab explores **serverless computing** in Microsoft Azure using
**Azure Functions** and **Azure Logic Apps**. You will create an Azure
Function to automate a task and design Logic App workflows that
integrate Azure services and external APIs. All workflows, triggers, and
actions are documented for clarity.

------------------------------------------------------------------------

## Part A: Understanding Serverless Computing & Azure Functions

### What is Serverless Computing?

Serverless computing allows developers to run code without managing
servers. Azure automatically handles: - Infrastructure provisioning -
Scaling - High availability - Maintenance

### Azure Functions -- Concept & Use Cases

**What it is:**\
Azure Functions is an event-driven, serverless compute service.

**Key Characteristics:** - No server management - Automatic scaling -
Pay-per-execution model

**Common Use Cases:** - File processing - Email notifications - API
backends - Scheduled jobs - Event handling (Blob uploads, HTTP requests)

------------------------------------------------------------------------

## Part B: Create an Azure Function (File Processing / Email Notification)

### Step 1: Create an Azure Function App

1.  Go to **Azure Portal → Create Resource → Function App**
2.  Configure:
    -   **Resource Group:** `rg-serverless-lab`
    -   **Function App Name:** `serverlessfunclab`
    -   **Runtime Stack:** Python
    -   **Hosting Plan:** Consumption
    -   **Storage Account:** Auto-create
3.  Click **Review + Create**

------------------------------------------------------------------------

### Step 2: Create an Azure Function (HTTP Trigger)

1.  Open the Function App
2.  Click **Functions → Create**
3.  Choose:
    -   **Trigger:** HTTP Trigger
    -   **Authorization:** Function
4.  Create the function

------------------------------------------------------------------------

### Step 3: Sample Azure Function Code (Email Notification Example)

``` python
import logging

def main(req):
    logging.info("Azure Function triggered")
    return {
        "status": 200,
        "body": "Email notification task executed successfully"
    }
```

------------------------------------------------------------------------

### Step 4: Test the Function

-   Use **Test/Run** in Azure Portal
-   Trigger via HTTP request
-   Verify response message

------------------------------------------------------------------------

## Part C: Introduction to Azure Logic Apps

### What is Azure Logic Apps?

Azure Logic Apps is a low-code service for automating workflows
between: - Azure services - SaaS platforms - On-premises systems -
External APIs

### Common Use Cases:

-   Email alerts
-   Data synchronization
-   Business process automation
-   Incident response workflows

------------------------------------------------------------------------

## Part D: Create Logic App Workflow (Service Integration)

### Step 1: Create a Logic App

1.  Go to **Azure Portal → Logic Apps → Create**
2.  Configure:
    -   **Resource Group:** `rg-serverless-lab`
    -   **Logic App Name:** `logicapp-automation`
    -   **Plan Type:** Consumption
3.  Create the Logic App

------------------------------------------------------------------------

### Step 2: Define Workflow Trigger

Choose a trigger such as: - **When an HTTP request is received** -
**When a blob is added or modified** - **Recurrence (Scheduled
trigger)**

Example: - Trigger: **When a Blob is Created (Azure Blob Storage)**

------------------------------------------------------------------------

### Step 3: Add Workflow Actions

Actions may include: - Send email (Outlook / SMTP) - Call Azure
Function - Write data to Blob Storage - Call external REST API

Example Actions: 1. Get Blob Content 2. Call Azure Function 3. Send
Email Notification

------------------------------------------------------------------------

## Part E: Workflow Documentation

### Example Workflow Overview

**Trigger:** - New file uploaded to Azure Blob Storage

**Actions:** 1. Read file content 2. Process file via Azure Function 3.
Send email notification

------------------------------------------------------------------------

### Workflow Table

  Component   Type               Description
  ----------- ------------------ ---------------------
  Trigger     Blob Created       Starts workflow
  Action 1    Get Blob Content   Reads uploaded file
  Action 2    Azure Function     Processes data
  Action 3    Email Connector    Sends notification

------------------------------------------------------------------------

## Security & Best Practices

-   Use Managed Identities for authentication
-   Avoid hardcoded secrets
-   Apply least privilege access
-   Monitor executions via Azure Monitor
-   Use retries and error handling in Logic Apps

------------------------------------------------------------------------

## Conclusion

This lab demonstrates how Azure Functions and Logic Apps enable
scalable, event-driven automation without server management. Together,
they form a powerful serverless architecture for modern cloud
applications.

------------------------------------------------------------------------

