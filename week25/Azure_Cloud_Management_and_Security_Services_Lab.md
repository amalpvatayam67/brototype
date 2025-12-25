# Azure Hands-On Lab: Cloud Management & Security Services

## Objective

This lab explores **essential Azure services for cloud management and
security**, focusing on **Azure Firewall, Azure DNS, and Azure
Monitor**. You will understand their purpose, configure core components,
and document key findings and practical outcomes.

---

## Part A: Overview of Additional Essential Azure Services

### Why These Services Matter

Modern cloud environments require: - Strong network security controls -
Reliable domain name resolution - Centralized monitoring and alerting

Azure Firewall, Azure DNS, and Azure Monitor together provide
**security, visibility, and operational control** over cloud workloads.

---

## Part B: Azure Firewall -- Traffic Control & Monitoring

### Concept & Purpose

Azure Firewall is a **cloud-native, stateful firewall** that protects
Azure Virtual Networks by filtering inbound and outbound traffic.

### Key Features

- Stateful packet inspection
- Application and network rules
- Centralized security policy
- Built-in high availability

---

### Azure Firewall Configuration (High-Level)

#### Step 1: Create Azure Firewall

1.  Go to **Azure Portal → Firewall → Create**
2.  Configure:
    - **Resource Group:** `rg-security-lab`
    - **Firewall Name:** `az-firewall-lab`
    - **VNet:** Dedicated VNet with `AzureFirewallSubnet`
    - **Public IP:** Create new

---

#### Step 2: Configure Firewall Rules

**Network Rules Example:** - Allow outbound HTTP (80) and HTTPS (443) -
Allow DNS (53)

**Application Rules Example:** - Allow access to `www.microsoft.com` -
Deny unknown external domains

---

### Practical Outcomes

- Centralized traffic inspection
- Reduced attack surface
- Improved compliance and auditing

---

## Part C: Azure DNS -- Domain Name Resolution

### Concept & Purpose

Azure DNS is a **highly available DNS hosting service** that manages
domain name resolution using Microsoft Azure infrastructure.

### Key Features

- Public and Private DNS zones
- High availability and low latency
- Integration with Azure VNets

---

### Azure DNS Configuration

#### Step 1: Create DNS Zone

1.  Go to **Azure Portal → DNS Zones → Create**
2.  Configure:
    - **Zone Name:** `examplelab.com`
    - **Resource Group:** `rg-security-lab`

---

#### Step 2: Create DNS Records

- **A Record:** Map domain to public IP
- **CNAME Record:** Alias one domain to another

---

### Practical Outcomes

- Centralized DNS management
- Faster and reliable name resolution
- Seamless integration with Azure resources

---

## Part D: Azure Monitor -- Performance, Logs & Alerts

### Concept & Purpose

Azure Monitor provides **full observability** into Azure resources by
collecting metrics, logs, and events.

### Key Features

- Real-time metrics
- Log Analytics
- Alerts and dashboards
- Integration with Azure Security Center

---

### Azure Monitor Configuration

#### Step 1: Enable Monitoring

- Automatically enabled for most Azure resources
- Connect resources to **Log Analytics Workspace**

---

#### Step 2: Configure Alerts

Example Alert: - Condition: CPU usage \> 80% - Action: Send email
notification

---

### Logs & Metrics Tracked

- VM CPU & memory
- Network traffic
- Firewall logs
- Application performance

---

### Practical Outcomes

- Proactive issue detection
- Faster troubleshooting
- Improved system reliability

---

## Part E: Documentation of Key Findings

### Summary Table

---

Service Purpose Key Configuration Outcome

---

Azure Network Rule-based filtering Secure traffic
Firewall security control

Azure DNS Name resolution DNS zones & records Reliable
routing

Azure Observability Metrics, logs, alerts Proactive
Monitor monitoring

---

---

## Security & Best Practices

- Use Azure Firewall with NSGs for layered security
- Enable diagnostic logs for all critical resources
- Use Private DNS zones for internal services
- Set alerts for abnormal activity

---

## Conclusion

Azure Firewall, Azure DNS, and Azure Monitor are critical components for
managing secure, scalable, and observable cloud environments. Together,
they enable strong security controls, reliable connectivity, and
continuous monitoring across Azure workloads.

---
