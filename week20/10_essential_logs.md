# 🔍 10 Essential Log Sources for Security Detection

Effective security monitoring and attack detection rely on centralizing and analyzing logs from diverse systems. This list covers the most critical log sources across the typical enterprise environment.

---

## Cloud & Infrastructure Logs

| ID | Log Source Name | Description | Key Security Events Detected |
| :--- | :--- | :--- | :--- |
| **1** | **Firewall / Network Device Logs** | Records of network connections, traffic flow, and security policy enforcement (e.g., Palo Alto, Cisco, AWS Security Groups). | **Intrusion attempts** (denies), **Port Scanning**, outbound connections to **known malicious IPs**, **Exfiltration**. |
| **2** | **Cloud Audit Logs (e.g., AWS CloudTrail, Azure Activity Log)** | Records all API calls and actions taken within a cloud environment (who did what, where, and when). | **Configuration changes** (deleting a rule, changing security settings), **Unauthorized resource deployment**, **Privilege escalation**. |
| **3** | **Web Proxy Logs** | Records of all outbound web requests made by users and systems, including URLs and user agents. | Access to **Command and Control (C2) domains**, **Phishing site access**, **Data exfiltration** attempts via unauthorized cloud storage. |
| **4** | **DNS Server Logs** | Records all domain name resolution queries made by internal hosts. | Communication with **Domain Generation Algorithm (DGA)** malware, **Tunneling attempts**, **Reconnaissance**. |

---

## Identity & Endpoint Logs

| ID | Log Source Name | Description | Key Security Events Detected |
| :--- | :--- | :--- | :--- |
| **5** | **Active Directory (AD) / LDAP Logs** | Records of user authentication, account changes, and group modifications within the identity store. | **Brute force attacks** (failed logins), **Account lockouts**, **Privilege escalation** (adding user to Admin group), **Golden Ticket attacks**. |
| **6** | **OS System / Security Logs** | General operating system events from Windows (Event Viewer) or Linux (Auditd, Syslog). | **Process creation/execution**, **System reboots**, **Failed attempts to stop security services**, **User creation**. |
| **7** | **Endpoint Detection and Response (EDR) / AV Logs** | Detailed logs from endpoint agents regarding file execution, process activity, and security alerts. | **Malware execution**, **Memory injection**, **Binary code modification**, **Ransomware activity**. |

---

## Application Logs

| ID | Log Source Name | Description | Key Security Events Detected |
| :--- | :--- | :--- | :--- |
| **8** | **Web Application Firewall (WAF) Logs** | Records attempts to exploit web applications before they reach the server. | **SQL Injection attempts**, **Cross-Site Scripting (XSS)**, **Path traversal**, **Bot attacks**. |
| **9** | **Web Server Access Logs (e.g., Apache, NGINX)** | Records HTTP requests made to the web server, including status codes and URI details. | **Error-based exploitation** (high rate of 4xx/5xx errors), **Unusual parameter usage**, **Web shell upload attempts**. |
| **10**| **Database Access Logs** | Records successful and failed attempts to query, modify, or access the database contents. | **Excessive query volumes** by a single user, **Unauthorized privilege use** (e.g., non-admin account running a DROP command), **Sensitive data access**. |