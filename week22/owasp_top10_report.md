# OWASP Top 10 (2021) — Summary, Impact, Prevention & Examples

The **OWASP Top 10** is the globally recognized list of the most critical security risks for web applications.  
This report summarises each category (A01–A10), real‑world impact, mitigation strategies, and examples.

---

## **A01: Broken Access Control**

### **Summary**
Improper enforcement of access rules allows attackers to access data or functionality they should not.

### **Real‑World Impact**
- Users can access others’ accounts  
- Unauthorized admin access  
- Data leaks and privilege escalation

### **Prevention**
- Enforce role-based access control (RBAC)  
- Deny by default  
- Server-side checks for every request  
- Use access control frameworks

### **Example**
- *Facebook private photo access bug (2019)* — attackers could access private photos using incorrect permission checks.

---

## **A02: Cryptographic Failures**  
*(Formerly Sensitive Data Exposure)*

### **Summary**
Failures in cryptography lead to exposure of sensitive data (PII, credentials, financial data).

### **Real‑World Impact**
- Credential theft  
- Financial fraud  
- Data breaches with regulatory penalties (GDPR)

### **Prevention**
- Use strong encryption (TLS 1.2+)  
- Never store passwords in plain text  
- Use HTTPS everywhere  
- Disable weak ciphers and protocols

### **Example**
- *Yahoo 2013 breach* — plaintext unencrypted security questions contributed to massive account compromise.

---

## **A03: Injection**

### **Summary**
Injection flaws occur when untrusted input reaches an interpreter (SQL, OS, LDAP).

### **Real‑World Impact**
- Database dump  
- Full server takeover  
- Credential theft

### **Prevention**
- Use prepared statements  
- Input validation + sanitization  
- Avoid dynamic queries  
- Use ORM frameworks

### **Example**
- *2022 Toyota Supplier breach* — SQL injection led to exposure of customer data.

---

## **A04: Insecure Design**

### **Summary**
Weaknesses in system design — flawed logic, missing security controls, lack of threat modeling.

### **Real‑World Impact**
- Security bypass  
- Business logic abuse  
- Fraud and financial loss

### **Prevention**
- Apply Secure SDLC  
- Threat modeling (STRIDE)  
- Security-driven architecture reviews  
- Validate business logic

### **Example**
- Unlimited money transfer attempts in mobile banking apps due to missing rate-limiting.

---

## **A05: Security Misconfiguration**

### **Summary**
Insecure default settings, exposed admin panels, unused features enabled.

### **Real‑World Impact**
- Full server takeover  
- Sensitive data exposure  
- RCE (Remote Code Execution)

### **Prevention**
- Harden servers  
- Disable unused ports & services  
- Automated configuration scanning  
- Enforce security baselines

### **Example**
- *Capital One AWS firewall misconfiguration (2019)* exposed 100M+ customer records.

---

## **A06: Vulnerable and Outdated Components**

### **Summary**
Using outdated libraries, plugins, frameworks with known vulnerabilities.

### **Real‑World Impact**
- RCE  
- Supply chain attacks  
- Data breaches

### **Prevention**
- Maintain SBOM (Software Bill of Materials)  
- Automated dependency scanning (Snyk, Dependabot)  
- Frequent patching policy  
- Monitor CVEs

### **Example**
- *Equifax breach (2017)* — Unpatched Apache Struts led to 143M+ customer data leak.

---

## **A07: Identification and Authentication Failures**

### **Summary**
Weak or broken authentication allows attackers to impersonate users.

### **Real‑World Impact**
- Account takeover  
- Fraud and identity theft  
- Unauthorized access

### **Prevention**
- Multi-factor authentication (MFA)  
- Secure session management  
- Strong password policies  
- Lock brute-force attempts

### **Example**
- *Instagram brute-force bug (2018)* allowed attackers to bypass rate limits and take over accounts.

---

## **A08: Software and Data Integrity Failures**

### **Summary**
Issues where code, updates, or CI/CD pipelines aren't verified or trusted.

### **Real‑World Impact**
- Supply chain attacks  
- Malware injection  
- Complete system compromise

### **Prevention**
- Code signing  
- Digital signatures on updates  
- Zero-trust CI/CD  
- Protect build pipelines

### **Example**
- *SolarWinds Supply Chain Attack (2020)* — trojanized update affected 18,000+ organizations.

---

## **A09: Security Logging and Monitoring Failures**

### **Summary**
Weak or missing logging allows attacks to go unnoticed.

### **Real‑World Impact**
- Delayed breach detection  
- No forensic evidence  
- Increased attack damage

### **Prevention**
- Implement centralized logging (ELK, Splunk)  
- Monitor critical events  
- Alerting and SIEM integration  
- Retain logs securely

### **Example**
- *Target breach (2013)* — alerts were generated but not monitored, leading to massive card theft.

---

## **A10: Server-Side Request Forgery (SSRF)**

### **Summary**
SSRF allows attackers to make the server send requests to internal services.

### **Real‑World Impact**
- Internal network scanning  
- Access to metadata (cloud tokens)  
- RCE in some cases

### **Prevention**
- Block internal IP address access  
- Allowlist external domains  
- Disable unnecessary URL fetchers  
- Filter user-supplied URLs

### **Example**
- *Microsoft Exchange SSRF (2021)* — allowed attackers to impersonate admin accounts and steal emails.

---

# **OWASP Top 10 Summary Table**

| Risk | Summary | Impact | Prevention |
|------|---------|---------|------------|
| A01 | Broken Access Control | Privilege escalation, data theft | RBAC, deny-by-default |
| A02 | Cryptographic Failures | Data exposure, breach | Strong encryption, HTTPS |
| A03 | Injection | DB hijacking, server takeover | Prepared statements, sanitize inputs |
| A04 | Insecure Design | Logic abuse, fraud | Threat modeling, secure SDLC |
| A05 | Security Misconfiguration | RCE, data leaks | Harden configs, scan regularly |
| A06 | Outdated Components | Exploits via CVEs | Patch management, SBOM |
| A07 | Auth Failures | Account takeover | MFA, secure sessions |
| A08 | Integrity Failures | Malware, supply chain attacks | Code signing, CI/CD hardening |
| A09 | Logging Failures | Undetected breaches | Centralized logging, SIEM |
| A10 | SSRF | Internal network attacks | Allowlist, block internal IPs |

---

# **Conclusion**

OWASP Top 10 provides essential guidance for preventing the most critical web application security risks.  
By understanding real-world impacts and implementing mitigations, organizations can greatly reduce the attack surface and improve resilience.

