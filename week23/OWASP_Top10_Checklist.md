# OWASP Top 10 Web Application Security Risks — Concise Checklist

A practical checklist to help testers and developers quickly validate security controls against the OWASP Top 10 risks.

---

##  A01: Broken Access Control
- [ ] Enforce proper role-based access control (RBAC)
- [ ] Prevent IDOR (Insecure Direct Object Reference)
- [ ] Block forced browsing to restricted endpoints
- [ ] Validate authorization on all API routes
- [ ] Restrict modification of user IDs, parameters, and tokens

---

##  A02: Cryptographic Failures
- [ ] Use HTTPS/TLS everywhere
- [ ] Disable outdated TLS versions and weak ciphers
- [ ] Encrypt sensitive data in transit and at rest
- [ ] Store passwords with strong hashing (bcrypt, Argon2, PBKDF2)
- [ ] Protect keys and secrets securely

---

##  A03: Injection
- [ ] Validate and sanitize all inputs server-side
- [ ] Use parameterized queries for SQL/NoSQL
- [ ] Prevent OS command injection
- [ ] Validate template variables to avoid template injection
- [ ] Reject unsafe characters in user inputs

---

##  A04: Insecure Design
- [ ] Apply threat modeling
- [ ] Use secure design patterns (rate limiting, validation layers)
- [ ] Require re-authentication for sensitive actions
- [ ] Enforce least privilege and separation of duties
- [ ] Avoid insecure workflow logic

---

##  A05: Security Misconfiguration
- [ ] Disable debug/error modes in production
- [ ] Remove default accounts and unused features
- [ ] Use secure HTTP headers (CSP, HSTS, X-Frame-Options)
- [ ] Ensure proper server and cloud configuration
- [ ] Limit information leakage through error messages

---

##  A06: Vulnerable and Outdated Components
- [ ] Track versions of all dependencies
- [ ] Update and patch components regularly
- [ ] Remove unused libraries and packages
- [ ] Avoid components with known CVEs
- [ ] Use supported, maintained versions of frameworks

---

##  A07: Identification and Authentication Failures
- [ ] Enforce strong password requirements
- [ ] Implement MFA where applicable
- [ ] Secure session cookies (HttpOnly, Secure, SameSite)
- [ ] Properly invalidate sessions on logout
- [ ] Protect authentication endpoints with rate limiting

---

##  A08: Software and Data Integrity Failures
- [ ] Verify integrity of software updates (signatures/hashes)
- [ ] Harden CI/CD pipeline security
- [ ] Avoid unsafe deserialization
- [ ] Enforce integrity checks on configuration files
- [ ] Validate data from all external sources

---

##  A09: Security Logging and Monitoring Failures
- [ ] Log authentication events, errors, and access violations
- [ ] Avoid logging sensitive data (passwords, tokens)
- [ ] Monitor logs for anomalies
- [ ] Configure alerting for critical events
- [ ] Ensure logs are stored securely with proper retention

---

##  A10: Server-Side Request Forgery (SSRF)
- [ ] Validate and sanitize URLs used by server-side fetches
- [ ] Restrict internal network access
- [ ] Use allowlists for outbound requests
- [ ] Block cloud metadata endpoint access
- [ ] Enforce timeout and redirect protections

---

## 📌 Final Recommendation
Use this checklist as part of:
- Secure code reviews  
- Penetration tests  
- Vulnerability assessments  
- DevSecOps pipelines  

Regular review ensures applications remain resistant to common and emerging threats.

