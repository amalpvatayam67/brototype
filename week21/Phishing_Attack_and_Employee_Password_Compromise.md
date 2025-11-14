# Case Study #2: Phishing Attack and Employee Password Compromise

## 1. Executive Summary

A regional grocery retailer experienced a phishing attack where an employee was tricked into entering credentials into a fraudulent login page. The attack was detected quickly, preventing further compromise. The cybersecurity team reset all passwords, implemented two-factor authentication, and initiated security awareness training.

---

## 2. Incident Overview

### 2.1 Organization

- Industry: Retail (Regional Grocery Chain)
- Departments Impacted: Employee Accounts, IT Security
- Severity Level: Medium

### 2.2 Incident Type

- Phishing attack
- Credential harvesting via fake login website

### 2.3 Detection

- Employee reported repeated login errors on a file-sharing site
- Employee verified with coworker that no document was sent
- Manager identified potential phishing attempt

### 2.4 Affected Assets

- Employee login credentials
- Email account access
- Potential access to internal applications (no confirmed intrusion)

---

## 3. Timeline of Events

| Time/Stage | Event Description                                                                                   |
| ---------- | --------------------------------------------------------------------------------------------------- |
| T0         | Employee receives email claiming a shared document from a coworker.                                 |
| T1         | Employee clicks link; fake file-sharing login page appears.                                         |
| T2         | Employee enters credentials twice and receives error messages.                                      |
| T3         | Employee contacts manager requesting password reset and reports coworker did not send any document. |
| T4         | Manager escalates to cybersecurity team.                                                            |
| T5         | Cybersecurity team confirms phishing site.                                                          |
| T6         | Passwords for all employees are reset.                                                              |
| T7         | Company-wide alert sent regarding phishing attempt.                                                 |
| T8         | Two-factor authentication implemented.                                                              |
| T9         | Security awareness training scheduled.                                                              |

---

## 4. Technical Investigation Findings

### 4.1 Root Cause

- Employee interacted with phishing email and entered personal login credentials into a fraudulent login form.

### 4.2 Attack Mechanism

- Fake email mimicked coworker communication
- Phishing link redirected to a counterfeit file-sharing site
- Credentials harvested and sent to attacker-controlled server

### 4.3 Security Weaknesses Identified

- Lack of two-factor authentication
- Insufficient employee phishing awareness
- No URL validation habits
- No email header verification procedures

---

## 5. Impact Analysis

### 5.1 Operational Impact

- Temporary account lockouts
- Company-wide password resets
- Interruption of workflow for employees

### 5.2 Financial Impact

- Minimal financial loss
- Incident response and training costs

### 5.3 Data Impact

- Employee credentials exposed
- No confirmed internal system breach
- No data theft detected

### 5.4 Reputational Impact

- Minor risk due to quick containment and reporting

---

## 6. Recovery Actions Performed

### 6.1 Containment

- Immediate password resets for all staff accounts
- Review of access logs for suspicious activity

### 6.2 Eradication

- Removal of phishing email from all mailboxes
- Blocking of phishing domain and IP

### 6.3 Recovery

- Implementation of two-factor authentication
- Notification to all employees about the incident
- Scheduled mandatory security training

---

## 7. Post-Incident Improvements

### 7.1 Technical Controls

- Implementation of MFA on all systems
- Improved email filtering and link scanning
- Enhanced login monitoring

### 7.2 Employee Training

- Phishing recognition
- Email verification techniques
- Safe handling of suspicious links

### 7.3 Policy Updates

- Mandatory reporting procedures
- Credential protection guidelines
- Strengthened IT security policies

---

## 8. Lessons Learned

1. Employees must verify unexpected document-sharing messages.
2. MFA significantly reduces credential-based compromise risks.
3. Phishing awareness training is highly effective in early detection.
4. Rapid reporting helps prevent data theft.

---

## 9. Recommendations

### High Priority

- Enforce MFA organization-wide
- Deploy advanced email filtering solutions
- Conduct monthly phishing tests

### Medium Priority

- Improve reporting channels for suspicious emails
- Perform quarterly security assessments

### Low Priority

- Update acceptable use policies
- Provide refresher training every 6 months

---

# Case Study #3: Infrastructure Monitoring Incident and Weak Password Exploitation

## 1. Executive Summary

An industrial thermostat manufacturer observed unusual login activity on company servers. Logs indicated unauthorized access using a weak password. Subsequent investigation revealed that attackers stole non-confidential data by encoding it into an image file stored on the company website. The incident highlighted deficiencies in monitoring, password policies, and infrastructure security.

---

## 2. Incident Overview

### 2.1 Organization

- Industry: Industrial Manufacturing (Thermostat Production)
- Departments Impacted: Servers, Network Infrastructure, IT Security
- Severity Level: Medium

### 2.2 Incident Type

- Unauthorized access due to weak password
- Data exfiltration via hidden image technique

### 2.3 Detection

- Unusual login times observed in security logs
- Credentials used legitimately but tied to weak password

### 2.4 Affected Assets

- Network and server login credentials
- Company website storage
- Non-confidential data archives

---

## 3. Timeline of Events

| Time/Stage | Event Description                                                    |
| ---------- | -------------------------------------------------------------------- |
| T0         | Analysts detect unusual login activity.                              |
| T1         | Credentials identified as commonly used weak password.               |
| T2         | Password changed immediately.                                        |
| T3         | Forensic imaging of servers initiated.                               |
| T4         | Investigation reveals data exfiltration method: image steganography. |
| T5         | Confirmation: Data stolen was non-confidential.                      |
| T6         | Infrastructure remediation plan created and implemented.             |

---

## 4. Technical Investigation Findings

### 4.1 Root Cause

- Use of a weak, common password allowed attackers direct access without deploying malware.

### 4.2 Attack Mechanism

- Unauthorized login using valid credentials
- Data collected and converted into image file format
- Image stored on website, accessible without authentication
- Attacker could retrieve stolen data on demand

### 4.3 Security Weaknesses Identified

- Weak password policy
- Lack of network monitoring and intrusion alerts
- No steganography detection tools
- Insufficient oversight of administrative accounts

---

## 5. Impact Analysis

### 5.1 Operational Impact

- Minimal operational disruption
- Security team required extensive forensic review

### 5.2 Financial Impact

- Forensic investigation and remediation expenses
- No regulatory fines due to non-confidential data

### 5.3 Data Impact

- Non-confidential data stolen and hidden in image files
- No personal or regulated data compromised

### 5.4 Reputational Impact

- Low impact since no customer disclosures were required

---

## 6. Recovery Actions Performed

### 6.1 Containment

- Password reset for compromised accounts
- Immediate lockdown of suspicious login activity

### 6.2 Eradication

- Removal of hidden malicious image files
- Cleanup of unauthorized access artifacts

### 6.3 Recovery

- Hardening of server configurations
- Logging and monitoring improvements

---

## 7. Post-Incident Improvements

### 7.1 Technical Controls

- Enforced strong password policies
- Continuous network and server monitoring
- Administrative account usage alerts
- Enhanced data access monitoring

### 7.2 Employee Training

- Password hygiene education
- Recognition of suspicious login attempts

### 7.3 Policy and Compliance Enhancements

- Updated security policy
- Regular password audits
- Required compliance testing for infrastructure security

---

## 8. Lessons Learned

1. Weak passwords remain a major vulnerability.
2. Attackers may use non-traditional methods such as data hiding in images.
3. Ongoing monitoring is essential to detect unusual behavior.
4. Strong access controls prevent unauthorized internal data retrieval.

---

## 9. Recommendations

### High Priority

- Enforce password complexity and rotation policies
- Implement SIEM-based continuous monitoring
- Inspect web server storage for unauthorized files

### Medium Priority

- Perform routine credential audits
- Improve logging and alert thresholds

### Low Priority

- Conduct steganography-awareness training for IT teams

---

# Conclusion

Both incidents highlight the importance of employee awareness, strong password policies, routine monitoring, and rapid detection. Organizations must adopt modern cybersecurity practices, enforce access controls, and ensure ongoing training to reduce attack surfaces and mitigate future threats.

---
