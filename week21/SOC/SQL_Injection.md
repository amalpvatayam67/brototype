# SOC127 – SQL Injection Detected

## Incident Type

True Positive

## Severity

High

---

# 1. Summary

A malicious SQL Injection attempt was detected from **118.194.247.28** targeting **WebServer1000 (172.16.20.12)**.

The attacker used a complex payload involving:

- UNION-based SQL Injection
- Stored XSS injection
- Attempted OS command execution (`xp_cmdshell`)
- Attempt to read `/etc/passwd`

The server responded with **HTTP 200**, and the firewall **allowed** the request.

---

# 2. Evidence

## 2.1 Suspicious HTTP Request Payload

```
GET /?douj=3034 AND 1=1
UNION ALL SELECT 1,NULL,'<script>alert("XSS")</script>',table_name
FROM information_schema.tables WHERE 2>1--/**/;
EXEC xp_cmdshell('cat ../../../etc/passwd')# HTTP/1.1
```

## 2.2 Indicators Observed

- SQL Injection (UNION-based)
- Stored XSS payload
- Attempted command execution via `xp_cmdshell`
- Tried accessing sensitive file `/etc/passwd`
- Source IP: **118.194.247.28**
- Response Code: **200 OK**
- Device Action: **Allowed**

---

# 3. Root Cause

The GET parameter **`douj`** in the application is vulnerable to SQL Injection.  
This allowed the attacker to:

- Inject malicious SQL queries
- Attempt JavaScript injection (XSS)
- Attempt OS command execution
- Bypass missing input validation

Lack of WAF protections also contributed to the issue.

---

# 4. Impact Assessment

- No signs of successful database extraction
- No signs of executing `xp_cmdshell`
- No compromise identified
- Attack attempt was detected but **not successful**

---

# 5. Actions Taken

## Immediate Response

- Blocked IP **118.194.247.28**
- Added SQLi patterns to WAF
- Reviewed logs for anomaly indicators

## Remediation & Hardening

- Confirmed `xp_cmdshell` is disabled
- Recommended parameterized queries
- Implemented better input validation

---

# 6. Status

**Closed – True Positive**  
The SQLi attack attempt was blocked from causing damage.
