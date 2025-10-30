# Data Loss Prevention (DLP) Explained

**Data Loss Prevention (DLP)** is a set of tools and processes designed to ensure that sensitive data is not lost, misused, or accessed by unauthorized users. DLP solutions classify regulated, confidential, and critical data and monitor its movement across the network, endpoints, and the cloud.

---

## 1. Endpoint Data Loss Prevention (EDLP)

**Endpoint DLP (EDLP)** focuses on securing data residing on and moving through **end-user devices**, such as laptops, desktops, and servers.

| Aspect | Description |
| :--- | :--- |
| **Focus Area** | Data at Rest and Data in Use on **endpoints**. |
| **Mechanism** | An **agent** is installed on the endpoint device. This agent monitors user actions (copy, paste, print, screenshot, transfer) and data transfer attempts via USB, Bluetooth, or local applications. |
| **Enforcement** | Can **block** unauthorized data transfers, **encrypt** files before movement, or simply **alert** administrators to policy violations. |
| **Key Use Case** | Preventing employees from copying sensitive customer lists onto a personal USB drive or uploading confidential documents to unauthorized cloud storage. |

---

## 2.Network Data Loss Prevention (NDLP)

**Network DLP (NDLP)** focuses on securing data that is **in transit** across the network, regardless of the source or destination device.

| Aspect | Description |
| :--- | :--- |
| **Focus Area** | Data **in Transit** over the network perimeter (email, web, FTP, instant messaging). |
| **Mechanism** | DLP software is typically deployed as a **proxy, gateway, or network appliance** that inspects all outgoing network traffic. It looks for sensitive data patterns (e.g., credit card numbers, PII) in the payload of packets. |
| **Enforcement** | Can **block** sensitive files from being sent over an unencrypted channel, **quarantine** emails with policy violations, or **terminate** network sessions. |
| **Key Use Case** | Blocking a file containing confidential financial records from being attached to an outside email or posted to a public website. |

---

## 3. Email Data Loss Prevention (Email DLP)

**Email DLP** is a specialized form of Network DLP that focuses exclusively on monitoring and protecting sensitive data transmitted via **corporate email systems**.

| Aspect | Description |
| :--- | :--- |
| **Focus Area** | Data moving via **email content** (body and attachments). |
| **Mechanism** | Integration with the corporate **Mail Transfer Agent (MTA)** or use of a **dedicated email security gateway**. It scans emails for sensitive keywords, regular expressions (e.g., Social Security Numbers), or file fingerprints. |
| **Enforcement** | **Quarantine** the email for review, **encrypt** the content automatically, **notify** the sender or receiver, or **block** the email entirely. |
| **Key Use Case** | Automatically encrypting an email attachment that contains customer health records before it leaves the organization, or blocking an email containing more than 10 credit card numbers. |

---

## Summary Comparison

| DLP Type | Data State Focus | Deployment Location | Primary Goal |
| :--- | :--- | :--- | :--- |
| **Endpoint (EDLP)** | At Rest/In Use | User Devices (Agent) | Control user behavior and local data transfer. |
| **Network (NDLP)** | In Transit | Network Perimeter (Gateway/Proxy) | Inspect and govern all network traffic leaving the organization. |
| **Email DLP** | In Transit | Mail Gateway/MTA | Enforce policies specifically on email content and attachments. |