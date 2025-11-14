# SOC176 – RDP Brute Force Detected

## Incident Type  
True Positive

## Severity  
High

---

# 1. Summary
A brute-force attack targeting the **RDP (Remote Desktop Protocol)** service was detected on host **Matthew (172.16.17.148)**.  
The attacker from **218.92.0.56** attempted multiple login attempts using **different non-existing accounts**.

RDP brute force is a common precursor to:
- Credential compromise  
- Ransomware deployment  
- Lateral movement inside the network  

The firewall action was **Allowed**, meaning the attack traffic reached the host.

---

# 2. Evidence

## 2.1 Alert Metadata
- **EventID:** 234  
- **Event Time:** Mar 07, 2024 – 11:44 AM  
- **Rule Triggered:** SOC176 – RDP Brute Force Detected  
- **Level:** Security Analyst  
- **Source IP:** 218.92.0.56  
- **Destination IP:** 172.16.17.148  
- **Destination Hostname:** Matthew  
- **Protocol:** RDP (TCP 3389)  
- **Firewall Action:** Allowed  
- **Alert Trigger Reason:**  
  *Login failure from a single source with different non-existing accounts*

---

# 2.2 Indicators of Attack
- Multiple failed authentication attempts  
- Attempts made using random & non-existent usernames  
- Repeated login failures within a short timeframe  
- Source IP 218.92.0.56 is known in threat intelligence for brute force activity  
- RDP service exposed and reachable  

---

# 3. Root Cause
The RDP port on **Matthew** is accessible from external or internal networks, allowing repeated login attempts.

Because the firewall **allowed** the traffic, the attacker could perform brute-force attempts using different usernames without interruption.

Potential root causes:
- Unrestricted inbound RDP access  
- Weak network segmentation  
- Default or predictable usernames  

---

# 4. Impact Assessment

### **Potential Impact**
- Account compromise through successful brute-force  
- Unauthorized remote access  
- Ransomware deployment (common post-RDP attack)  
- Privilege escalation  
- Full system takeover  

### **Confirmed Impact**
- Only login failures observed  
- No successful authentication detected  
- No lateral movement identified  
- No suspicious processes or commands detected  

Impact is low because the brute force did not succeed.

---

# 5. Actions Taken

## Immediate Response
- Blocked malicious source IP **218.92.0.56**  
- Forced review of RDP access rules for host **Matthew**  
- Checked Windows Security Event Logs for:
  - Event ID 4625 (failed logins)
  - Event ID 4624 (successful logins)
- Verified no unusual successful logins around the event time  

## Hardening Measures
- Restricted inbound RDP access to VPN-only  
- Enabled account lockout policy (temporary IP ban after failed attempts)  
- Enabled RDP Network Level Authentication (NLA)  
- Recommended moving RDP behind a jump server  
- Ensure strong, unique passwords for all accounts  
- Enabled logging & monitoring for future attempts  

---

# 6. Recommendations
- Disable direct RDP exposure whenever possible  
- Allow RDP only from approved internal networks  
- Implement MFA for RDP access  
- Deploy honeypot or fail2ban-style blocking  
- Monitor for repeated login failures from new IP addresses  
- Review all user accounts for strong password compliance  

---

# 7. Final Status
**Closed – True Positive**  
RDP brute-force attempt detected.  
No compromise identified; traffic blocked and host secured.

