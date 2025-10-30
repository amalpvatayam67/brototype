# 🚨 20 SIEM Security Detection Rule Logics

These rules are designed to detect common and critical security threats across various log sources (e.g., Active Directory/Authentication, Firewall/Network, Endpoint/OS, Web/Application).

---

## 1. Unauthorized Access & Brute Force

These rules focus on identifying suspicious login attempts and access failures.

| ID       | Rule Logic (Pseudocode)                                                                                                                                       | Threat Category          | Log Source             |
| :------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------ | :----------------------- | :--------------------- |
| **R-01** | `COUNT(Auth Failures)` from a single `Source IP` > 10 in 60 seconds.                                                                                          | Brute Force Attack       | Firewall, Auth Server  |
| **R-02** | `COUNT(Successful Logins)` for the same `Account` from 3+ different `Geo Locations` within 5 minutes.                                                         | Impossible Travel/Access | VPN, Cloud App         |
| **R-03** | Alert when a successful login occurs for a **disabled or expired account**.                                                                                   | Unauthorized Access      | Auth Server (AD/LDAP)  |
| **R-04** | Alert when a system detects a login attempt using a **default or well-known service account** name (e.g., 'administrator', 'guest', 'testuser') and it fails. | Credential Harvesting    | Server OS, Application |
| **R-05** | `COUNT(Failed Logins)` for 10+ different `Accounts` from the same `Source IP` within 5 minutes.                                                               | Reverse Brute Force      | Auth Server (AD/LDAP)  |

---

## 2. Privilege Escalation & Account Misuse

These rules track changes to user permissions and high-risk account activity.

| ID       | Rule Logic (Pseudocode)                                                                                                                | Threat Category       | Log Source               |
| :------- | :------------------------------------------------------------------------------------------------------------------------------------- | :-------------------- | :----------------------- |
| **R-06** | Alert when a user account is **added to the Domain Admins, Enterprise Admins, or a custom High-Value Group**.                          | Privilege Escalation  | AD/Directory Service     |
| **R-07** | Alert on a `Successful Login` by any **Service Account** to an interactive desktop session (e.g., RDP, Console).                       | Account Misuse        | Server OS, RDP Logs      |
| **R-08** | Alert when a **critical system configuration file** (e.g., `/etc/passwd`, `hosts`, registry keys) is modified by a non-system account. | System Tampering      | OS Logs (Auditd, Sysmon) |
| **R-09** | Alert when a **Local Admin Account** is created on 10+ different endpoints within 24 hours.                                            | Lateral Movement Prep | Endpoint Security        |
| **R-10** | Alert when a **password hash dump utility** (e.g., mimikatz, hashdump.exe) is executed on any system.                                  | Credential Theft      | Endpoint Security        |

---

## 3. Malware & Endpoint Activity

These rules identify anomalous process execution and communication patterns associated with malware.

| ID       | Rule Logic (Pseudocode)                                                                                                        | Threat Category   | Log Source                 |
| :------- | :----------------------------------------------------------------------------------------------------------------------------- | :---------------- | :------------------------- |
| **R-11** | Alert when an executable runs from a **non-standard, high-risk directory** (e.g., `C:\Users\Public`, Temp folders).            | Malware Execution | Endpoint Security          |
| **R-12** | Alert when a process attempts to **disable endpoint security services** (e.g., stopping Windows Defender, disabling firewall). | Defense Evasion   | OS Logs, Endpoint Security |
| **R-13** | Alert when a system makes an outbound connection to an IP address identified as a **known Command and Control (C2) server**.   | C2 Communication  | Firewall, Proxy            |
| **R-14** | Alert when a user creates or modifies a **Scheduled Task** that executes a PowerShell script or a known suspicious executable. | Persistence       | OS Logs (Task Scheduler)   |

---

## 4. Data Exfiltration & Policy Violations

These rules monitor data movement outside the corporate environment.

| ID       | Rule Logic (Pseudocode)                                                                                                                       | Threat Category             | Log Source         |
| :------- | :-------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------- | :----------------- |
| **R-15** | Alert when a single user uploads > 100MB of data to a **personal cloud storage service** (e.g., Dropbox, Google Drive).                       | Data Exfiltration           | Proxy, DLP Logs    |
| **R-16** | Alert on a **high volume of firewall deny events** followed immediately by a small, successful network connection to an external destination. | Port Scanning/Egress Test   | Firewall           |
| **R-17** | Alert when a **database server** initiates an outbound connection to an external, public IP address.                                          | Database Leakage            | Database, Firewall |
| **R-18** | Alert when a successful **VPN connection** is immediately followed by a high-volume file transfer to an external resource.                    | Insider Threat/Exfiltration | VPN, Proxy, DLP    |

---

## 5. Infrastructure & System Security

These rules focus on critical changes to security infrastructure.

| ID       | Rule Logic (Pseudocode)                                                                                                                             | Threat Category          | Log Source          |
| :------- | :-------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------- | :------------------ |
| **R-19** | Alert when a **Firewall Rule is deleted, modified, or a new ANY/ANY rule is created**.                                                              | Policy Evasion/Misconfig | Firewall Management |
| **R-20** | Alert when **excessive volumes of internal DNS lookups** occur for domains that are not typical for the environment (Domain Generation Algorithms). | Reconnaissance/Malware   | DNS Server Logs     |
