# Incident Investigation Report

## Case Study: Hong Kong IoT Service Provider – RDP Abuse & PowerShell Misuse (Blackpanda)

---

## 1. Executive Summary

In **May 2024**, a Hong Kong–based IoT service provider detected suspicious remote login attempts from overseas IP addresses, anomalous PowerShell behavior, and unusual Netlogon activity.

Alarmed by the signs, the organization engaged Blackpanda’s On-Demand Incident Response (ODIR) capability. Blackpanda conducted a forensic investigation across memory, disk, and logs, decoded PowerShell payloads, and reviewed internal login and credential hygiene.

**Key findings**:

- Encoded PowerShell commands were discovered and decoded.
- There were suspicious login patterns; however, **no malware**, no lateral movement, and no confirmed data exfiltration were found.
- Netlogon anomalies likely stemmed from undocumented internal testing.
- The company’s credential practices and endpoint hygiene were assessed to be high risk.

Blackpanda recommended several improvements: centralizing logs, locking down RDP, disabling or restricting PowerShell ISE, tightening credential policies, and improving endpoint hygiene.

The investigation concluded that while there were real threat signals, the incident did **not escalate to a breach**. Blackpanda estimated that using its **IR-1** subscription model could have cost the company ~12x less than the ODIR engagement for this incident.

---

## 2. Incident Overview

### 2.1 Organization

- **Sector:** IoT / Technology Services
- **Location:** Hong Kong
- **Type of Service:** IoT infrastructure provider

### 2.2 Incident Type

- External access attempts (RDP abuse)
- PowerShell misuse (via `powershell_ise.exe`)
- Suspicious Netlogon activity
- Incomplete telemetry on some endpoints

### 2.3 Detection

- Repeated failed Remote Desktop Protocol (RDP) login attempts from a China-based IP address.
- Internal execution of PowerShell via `powershell_ise.exe` using encoded payloads.
- Unexplained Netlogon behavior on a secondary system.
- Telemetry gaps from certain endpoints, making full visibility difficult.

### 2.4 Affected Assets

- User workstations / endpoints
- Domain controllers or systems with Netlogon interactions
- PowerShell environment / scripting environment
- Credential stores (local admin accounts)

---

## 3. Timeline of Events

| **Time / Stage** | **Event**                                                                       |
| ---------------- | ------------------------------------------------------------------------------- |
| **May 2024**     | Unusual RDP login attempts detected.                                            |
|                  | PowerShell activity via `powershell_ise.exe` with encoded payloads noticed.     |
|                  | Netlogon behavior flagged on a second system.                                   |
|                  | Telemetry gaps identified; inconsistent endpoint logging.                       |
|                  | Internal IT isolates affected systems and engages Blackpanda via ODIR.          |
|                  | Blackpanda responds with full endpoint, disk, and memory investigations.        |
|                  | PowerShell commands are decoded and analyzed.                                   |
|                  | Login patterns are reviewed; credential hygiene assessed.                       |
|                  | Netlogon anomalies correlated to internal testing (not malicious).              |
|                  | Final conclusion: no breach-level incident, but high-risk practices identified. |
|                  | Remediation guidance provided; cost comparison made between ODIR and IR-1.      |

---

## 4. Technical Investigation Findings

### 4.1 Root Cause

- The attacker likely tried to abuse **RDP exposed to internet** from overseas IPs.
- Use of `powershell_ise.exe` with **encoded PowerShell payloads** indicated a potential script-based attack or reconnaissance.
- Telemetry gaps meant some endpoints were not fully monitored, reducing visibility for detection.

### 4.2 Attack Mechanism

- Multiple failed login attempts to local admin accounts via RDP.
- Execution of PowerShell ISE with encoded commands suggests possible misuse of a trusted scripting host. {index=28}
- Netlogon anomalies could be misuse or benign internal testing – no malicious software was confirmed.
- No malware, no lateral movement, no data exfiltration detected.

### 4.3 Security Weaknesses Identified

- **RDP exposure**: external RDP access was not sufficiently locked down.
- **PowerShell policy**: PowerShell ISE (interactive scripting environment) was allowed, and encoded scripts were not restricted.
- **Credential hygiene**: local admin accounts had poor credential hygiene; high risk.
- **Logging / Telemetry**: Some endpoints lacked proper telemetry, making comprehensive detection difficult. {index=34}
- **Internal testing not documented**: Netlogon unusual behavior likely came from internal test activity, but lack of documentation made investigation harder.

---

## 5. Impact Analysis

### 5.1 Operational / Security Impact

- Risk of unauthorized remote access via RDP
- Potential for script-based attacks or PowerShell misuse on endpoints
- High-risk credential exposure due to weak hygiene
- Limited visibility due to telemetry gaps

### 5.2 Data Impact

- **No confirmed data exfiltration**.
- No evidence of malware or lateral movement.
- Netlogon anomalies attributed to internal testing rather than a breach.

### 5.3 Financial / Cost Impact

- ODIR engagement cost: ~ US$ 60,000 (≈120 hours @ US$500/hr)
- Potential risk avoided if attacker gained persistent access: lateral movement, credential theft, ransomware, exfiltration

### 5.4 Reputational Impact

- As no breach occurred, reputational damage is limited
- But risk signals could undermine stakeholder trust if not remediated

---

## 6. Response and Recovery Actions

### 6.1 Containment

- Blackpanda’s ODIR team initiated forensic response across multiple endpoints.
- Affected systems were isolated for analysis.

### 6.2 Eradication / Analysis

- Memory and disk imaging performed on suspect endpoints.
- Encoded PowerShell commands decoded and analysed.
- Login and authentication patterns audited.
- Netlogon behavior reviewed and correlated with internal test activity.

### 6.3 Recovery / Remediation

- No malware removal was needed because none was found.
- Blackpanda provided a remediation playbook.

---

## 7. Post-Incident Recommendations

1. **Centralize and Retain Logs**
   - Aggregate system, network, and security logs in a centralized log management/ SIEM system.
2. **Lock Down External RDP**
   - Restrict RDP access to known IPs.
   - Disable RDP on endpoints that don't require it.
3. **Harden PowerShell Use**
   - Disable or restrict PowerShell ISE.
   - Enforce script signing / execution policy so only signed scripts run.
4. **Improve Credential Hygiene**
   - Enforce strong, unique passwords for local admin accounts.
   - Regularly audit and rotate credentials.
5. **Fill Telemetry Gaps**
   - Ensure all endpoints have endpoint detection/response (EDR) or at least logging agents.
   - Monitor Netlogon and system telemetry for anomalies.
6. **Document Internal Tests**
   - Maintain records of internal testing or maintenance activities so anomalous logs can be correlated and not misinterpreted as malicious.

---

## 8. Lessons Learned

- **RDP remains a high-risk vector**: remote desktop exposure is dangerous if not tightly controlled.
- **PowerShell misuse is subtle**: trusted tools like `powershell_ise.exe` can be leveraged for malicious behavior.
- **Logging gaps reduce detection**: lack of full telemetry can blind a security team to anomalous behavior.
- **Internal testing without documentation** complicates incident triage.
- **High-risk practices may not immediately lead to breach**, but they must be addressed proactively.

---

## 9. Cost / Value Analysis

- **Cost of ODIR engagement**: ~US$ 60,000 for this incident.
- **Estimated cost via IR-1 model** (if subscribed): Annual subscription ~US$ 5,000 with unlimited IR credit.
- **Value of IR-1** in this case: ~12x cost savings, plus faster, more predictable response.

---

## 10. Conclusion

This incident at the Hong Kong IoT service provider exposed serious risks related to remote access (RDP), script misuse, and telemetry blind spots. While no breach was confirmed, the presence of real threat signals warranted a full forensic investigation.

Blackpanda’s ODIR engagement enabled the provider to validate the risk, remediate insecure practices, and operate with greater confidence. The remediation guidance provided will help to harden systems, improve visibility, and reduce the likelihood of more dangerous escalation in the future.

---

_This report is based on publicly available information from Blackpanda’s case study._
