# Azure Hands-On Lab: VM, Networking, NSG, and Load Balancer

## Objective

This hands-on lab guides you through launching a Virtual Machine (VM) in
Microsoft Azure, hosting a simple website, configuring secure networking
using Virtual Networks (VNet) and Network Security Groups (NSGs), and
implementing a Load Balancer to ensure high availability.

------------------------------------------------------------------------

## Prerequisites

-   Active Microsoft Azure account
-   Basic understanding of networking concepts
-   SSH client (Linux/macOS) or PuTTY (Windows)

------------------------------------------------------------------------

## Step A: Launch and Configure a Virtual Machine (VM)

### Steps (Azure Portal):

1.  Sign in to the **Azure Portal**
2.  Navigate to **Virtual Machines → Create → Azure Virtual Machine**
3.  Configure:
    -   **Resource Group:** Create new (e.g., `rg-web-lab`)
    -   **VM Name:** `web-vm-01`
    -   **Region:** Choose nearest region
    -   **Image:** Ubuntu Server 20.04 LTS
    -   **Size:** Standard B1s
4.  Authentication:
    -   Use **SSH public key** (recommended)
5.  Networking:
    -   Create a new **Virtual Network**
    -   Create a new **Subnet**
6.  Review and **Create** the VM

------------------------------------------------------------------------

## Step B: Host a Simple Website on the VM

### Connect to the VM:

``` bash
ssh azureuser@<VM_PUBLIC_IP>
```

### Install Web Server:

``` bash
sudo apt update
sudo apt install -y apache2
```

### Create Test Web Page:

``` bash
sudo echo "<h1>Azure VM Website Running</h1>" > /var/www/html/index.html
```

### Verify:

-   Open browser and visit: `http://<VM_PUBLIC_IP>`

------------------------------------------------------------------------

## Step C: Create and Configure a Virtual Network (VNet)

### VNet Configuration:

-   **Address Space:** `10.0.0.0/16`
-   **Subnet:** `10.0.1.0/24`

### Purpose:

-   Isolate resources securely
-   Enable private communication between VMs
-   Support future scalability

------------------------------------------------------------------------

## Step D: Configure Network Security Groups (NSGs)

### Create NSG:

1.  Go to **Network Security Groups → Create**
2.  Attach NSG to:
    -   Subnet or
    -   VM Network Interface (NIC)

### Inbound Security Rules:

  Priority   Port   Protocol   Action   Purpose
  ---------- ------ ---------- -------- ------------------
  100        22     TCP        Allow    SSH
  200        80     TCP        Allow    HTTP
  300        443    TCP        Allow    HTTPS
  400        \*     Any        Deny     Block all others

### Result:

-   Only essential traffic is allowed
-   Reduces attack surface

------------------------------------------------------------------------

## Step E: Implement Azure Load Balancer

### Architecture:

-   Two or more VMs in same VNet
-   Load Balancer distributes traffic

### Steps:

1.  Create **Azure Load Balancer**
    -   Type: Public
2.  Configure:
    -   Frontend IP
    -   Backend pool (add VMs)
    -   Health Probe (HTTP port 80)
    -   Load Balancing Rule (TCP 80)
3.  Ensure:
    -   Web server installed on all backend VMs

### Test:

-   Access Load Balancer public IP
-   Refresh multiple times
-   Traffic is distributed across VMs

------------------------------------------------------------------------

## Security & High Availability Benefits

-   **NSGs:** Enforce least-privilege access
-   **VNet:** Secure internal communication
-   **Load Balancer:** Fault tolerance & scalability
-   **VM Replication:** Ensures uptime

------------------------------------------------------------------------

## Conclusion

This lab demonstrates how core Azure services integrate to build a
secure, scalable, and highly available infrastructure. These steps
reflect real-world cloud deployment patterns used in production
environments.

------------------------------------------------------------------------
