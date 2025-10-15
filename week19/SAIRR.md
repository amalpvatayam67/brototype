# Security Attack Incident Response Report

This report details 10 common security attacks faced by companies and outlines the specific actions the **Security Operations Center (SOC) team** would take during each stage of the **Incident Response (IR) program** ($\text{Preparation, Identification, Containment, Eradication, Recovery, Lessons Learned}$) for each attack.

---

## 1. Phishing Attack

### Description and How it Occurs

**Phishing** is a form of social engineering where an attacker attempts to trick a user into revealing sensitive information (like credentials, credit card numbers) or downloading malware by disguising as a trustworthy entity in an electronic communication (usually email).

- **How it Happens:** An attacker sends a deceptive email, often containing a malicious link or an attachment. The email typically creates a sense of urgency, fear, or a compelling reason to click (e.g., "Your account has been suspended," "Urgent invoice attached," "Verify your login details"). If the user clicks the link, they are directed to a fake website designed to steal credentials. If they open the attachment, it can install malware.

### SOC Incident Response Program Actions

| Stage               | SOC Team Actions                                                                                                                                                                                                                                                                                                                                                      |
| :------------------ | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Preparation**     | **Develop and implement security awareness training** (mandatory and recurrent) for all employees on recognizing phishing. **Configure email filters** (spam, $\text{DMARC, SPF, DKIM}$) to block known malicious emails. **Establish clear reporting channels** for suspicious emails. Maintain **up-to-date endpoint protection** and **network monitoring tools**. |
| **Identification**  | **Analyze reported emails** (headers, links, attachments) to confirm if they are malicious. **Search email logs** for similar emails across the organization. **Check user login/activity logs** if the user clicked and entered credentials. **Isolate affected endpoints** if malware was downloaded.                                                               |
| **Containment**     | **Block the malicious sender address** and $\text{URL}$/domain at the email gateway and network perimeter (firewall/proxy). **Remove the malicious email** from all user inboxes using email filtering tools. **Force password resets** for any accounts confirmed or suspected of compromise.                                                                        |
| **Eradication**     | **Clean or re-image** any machines that were infected with malware via the phishing attachment. **Ensure all blocked $\text{IPs/URLs}$** are persistent across security tools. **Confirm successful removal** of the threat and any backdoors.                                                                                                                        |
| **Recovery**        | **Notify affected users** (after the threat is contained). **Monitor for unusual activity** on compromised accounts and endpoints for a defined period. **Restore user access** to services after password resets and endpoint cleanup.                                                                                                                               |
| **Lessons Learned** | **Analyze successful phishing attempts** to improve awareness training content (e.g., focus on new lures). **Evaluate the performance of email security tools** and tune filters. **Update $\text{IR}$ playbooks** based on any procedural gaps identified.                                                                                                           |

---

## 2. Malware Infection (Ransomware)

### Description and How it Occurs

**Ransomware** is a type of malware that encrypts a victim's files, rendering them unusable, and demands a ransom payment (usually in cryptocurrency) for the decryption key.

- **How it Happens:** Ransomware typically enters a network via phishing emails, exploited vulnerabilities in network services, or malicious downloads. Once on a system, it rapidly executes, encrypts critical files (documents, databases, etc.), and often attempts to spread laterally to other connected systems and network shares. A ransom note is then displayed to the user.

### SOC Incident Response Program Actions

| Stage               | SOC Team Actions                                                                                                                                                                                                                                                                                                               |
| :------------------ | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Preparation**     | **Implement a robust, segmented backup strategy** (3-2-1 rule, air-gapped backups). **Ensure endpoint detection and response ($\text{EDR}$) tools** are deployed and updated. **Regularly patch operating systems and applications**. **Restrict user permissions** (Principle of Least Privilege) to limit lateral movement.  |
| **Identification**  | **Alert verification** (e.g., multiple file encryption alerts, presence of a ransom note). **Identify the initial point of compromise** (root cause). **Determine the scope** of the infection (which systems, shares, or network segments are affected). **Identify the specific strain** of ransomware.                      |
| **Containment**     | **Immediately isolate** all infected and potentially infected endpoints and servers from the network. **Disable network connectivity** to file shares. **Temporarily disable or block $\text{C\&C}$ (Command and Control)** communications at the firewall. **Take a forensic image** of the initial patient zero if possible. |
| **Eradication**     | **Do NOT pay the ransom** (unless absolutely necessary as a last resort). **Wipe and rebuild** infected systems from trusted, clean images. **Analyze the root cause** (e.g., unpatched software, weak RDP password) and fix the vulnerability. **Verify backups** are clean before restoration.                               |
| **Recovery**        | **Restore systems and data** from clean backups, starting with the most critical business functions. **Test the restored systems** to ensure full operational capacity and data integrity. **Bring systems back online** in a controlled, phased manner.                                                                       |
| **Lessons Learned** | **Review backup and recovery processes** for speed and effectiveness. **Enhance segmentation** to prevent future lateral spread. **Update security controls** based on the ransomware's $\text{TTPs}$ (Tactics, Techniques, and Procedures).                                                                                   |

---

## 3. Distributed Denial of Service ($\text{DDoS}$) Attack

### Description and How it Occurs

A **$\text{DDoS}$ attack** is a malicious attempt to disrupt the normal traffic of a targeted server, service, or network by overwhelming the target or its surrounding infrastructure with a flood of Internet traffic from multiple compromised computer systems (a botnet).

- **How it Happens:** An attacker leverages a botnet (a network of compromised devices) to simultaneously send a massive volume of traffic (e.g., $\text{SYN}$ floods, $\text{UDP}$ floods, $\text{HTTP}$ requests) to the victim's server or application, consuming all available resources (bandwidth, $\text{CPU}$, memory), which causes legitimate users to be denied service.

### SOC Incident Response Program Actions

| Stage               | SOC Team Actions                                                                                                                                                                                                                                                                                                         |
| :------------------ | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Preparation**     | **Contract with a $\text{DDoS}$ mitigation service provider**. **Implement network architecture redundancy** and autoscaling. **Maintain high-capacity internet links**. **Establish clear communication procedures** with the $\text{ISP}$ and mitigation provider.                                                     |
| **Identification**  | **Monitor network traffic anomalies** (sudden, massive spike in volume, high $\text{CPU}$ utilization, service unavailability). **Analyze traffic patterns** to distinguish the attack from legitimate load spikes (e.g., source $\text{IP}$ spread, packet type). **Verify with the $\text{ISP}$ or hosting provider**. |
| **Containment**     | **Divert traffic** to the $\text{DDoS}$ mitigation provider's scrubbing center. **Implement $\text{rate}$-limiting** on network devices. **Apply $\text{ACLs}$ (Access Control Lists)** to block obvious attack $\text{IPs}$ or $\text{geolocations}$.                                                                   |
| **Eradication**     | **Filter out malicious traffic** at the edge using the $\text{DDoS}$ mitigation service (scrubbing). **Adjust firewall rules** to allow only clean traffic. **Monitor the attack source** for $\text{TTPs}$ to better configure filters.                                                                                 |
| **Recovery**        | **Restore normal traffic routing** after the attack subsides and mitigation is confirmed. **Verify service availability** and performance metrics ($\text{latency, uptime}$). **Ensure the firewall and network devices** are operating normally after the resource strain.                                              |
| **Lessons Learned** | **Review the effectiveness of the mitigation service** and current configurations. **Analyze the attack volume and type** to determine if current capacity is adequate. **Update $\text{DDoS}$ thresholds** and alert mechanisms.                                                                                        |

---

## 4. Insider Threat

### Description and How it Occurs

An **Insider Threat** involves a current or former employee, contractor, or business partner who has authorized access to an organization's network, systems, or data and uses that access, intentionally or unintentionally, to compromise the confidentiality, integrity, or availability of information.

- **How it Happens:** This can be **malicious** (e.g., an unhappy employee deliberately stealing trade secrets or sabotaging systems) or **negligent** (e.g., an employee accidentally emailing sensitive data to the wrong person, or using weak $\text{passwords}$). The threat leverages legitimate access, making detection difficult.

### SOC Incident Response Program Actions

| Stage               | SOC Team Actions                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| :------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Preparation**     | **Implement $\text{User}$ and $\text{Entity}$ Behavior $\text{Analytics}$ ($\text{UEBA}$) solutions** to monitor for abnormal activity (e.g., massive data downloads, login from unusual locations, access to unauthorized files). **Enforce Principle of Least Privilege** and $\text{Role}$-$\text{Based}$ $\text{Access}$ $\text{Control}$ ($\text{RBAC}$). **Mandate $\text{Non}$-$\text{Disclosure}$ $\text{Agreements}$ ($\text{NDAs}$) and clear $\text{Acceptable}$ $\text{Use}$ $\text{Policies}$.** |
| **Identification**  | **Investigate $\text{UEBA}$ alerts** for data exfiltration attempts (e.g., high-volume downloads, use of personal cloud services). **Review access logs** for accounts accessing sensitive data they don't normally use. **Coordinate with $\text{HR}$ and $\text{Legal}$** immediately upon suspicion.                                                                                                                                                                                                       |
| **Containment**     | **Immediately revoke all access** for the suspected individual (network, email, physical). **Isolate the individual's devices** (laptops, phones) for forensic analysis. **Monitor related user accounts** (e.g., colleagues) for any signs of collusion or shared credentials.                                                                                                                                                                                                                               |
| **Eradication**     | **Forensically analyze** the individual's $\text{PC}$ and network activity to determine the full scope of the compromise. **Secure or delete** any data found on unauthorized personal devices or cloud storage. **Change credentials** for any systems the insider may have compromised.                                                                                                                                                                                                                     |
| **Recovery**        | **Audit all data** the individual had access to, confirming no ongoing data exfiltration. **Restore any potentially corrupted or deleted data** from backups. **Review and tighten access controls** for the affected data or systems.                                                                                                                                                                                                                                                                        |
| **Lessons Learned** | **Review the $\text{UEBA}$ rules** and $\text{monitoring}$ scope to better detect similar future activities. **Enhance off-boarding processes** to ensure immediate access revocation. **Reinforce security policies** and the consequences of misuse.                                                                                                                                                                                                                                                        |

---

## 5. SQL Injection ($\text{SQLi}$)

### Description and How it Occurs

**$\text{SQL}$ $\text{Injection}$ ($\text{SQLi}$)** is a vulnerability that occurs when an attacker can interfere with the queries that an application makes to its database. This often allows the attacker to view data that they are not normally able to retrieve, and in some cases, modify or destroy data.

- **How it Happens:** An application uses user input directly in an $\text{SQL}$ query without proper sanitization. An attacker injects $\text{SQL}$ code (e.g., `' $\text{OR}$ '1'='1' --`) into a web input field (like a login or search bar). The application executes the malicious code, often bypassing authentication or retrieving unauthorized data from the database.

### SOC Incident Response Program Actions

| Stage               | SOC Team Actions                                                                                                                                                                                                                                                                                                                         |
| :------------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Preparation**     | **Use a Web $\text{Application}$ $\text{Firewall}$ ($\text{WAF}$)** to filter malicious input. **Train developers** in secure coding practices (e.g., using **prepared statements** or **parameterized queries**). **Regularly scan applications** for $\text{SQLi}$ and other vulnerabilities.                                          |
| **Identification**  | **Review $\text{WAF}$ logs** and application server logs for $\text{SQLi}$ attempt patterns (e.g., use of quotes, $\text{UNION, SELECT}$). **Analyze database query logs** for unauthorized or unusual queries. **Check for data exfiltration** attempts.                                                                                |
| **Containment**     | **Block the source $\text{IP}$ address** at the $\text{WAF}$ or perimeter firewall. **Take the vulnerable application offline** immediately or disable the specific function/input field that is being exploited. **Audit the database permissions** to ensure the web application user only has necessary privileges (Least Privilege). |
| **Eradication**     | **Fix the underlying code vulnerability** by implementing **prepared statements** or using robust input validation and sanitization. **Patch the vulnerable application** with the fixed code. **Search the database** for any injected backdoors or modified data.                                                                      |
| **Recovery**        | **Restore any corrupted or deleted data** from a clean backup (if necessary). **Place the fixed application back into production**. **Monitor the application logs** closely after deployment for recurring injection attempts.                                                                                                          |
| **Lessons Learned** | **Mandate a code review** focused on input sanitization and secure $\text{SQL}$ practices before any future deployments. **Review $\text{WAF}$ rules** and tune them to block the specific exploit used. **Improve developer training**.                                                                                                 |

---

## 6. Zero-Day Exploit

### Description and How it Occurs

A **Zero-Day Exploit** is an attack that leverages a previously unknown software vulnerability for which a patch (a "day zero" fix) does not yet exist. The vulnerability is typically exploited immediately upon discovery by the attacker.

- **How it Happens:** A vendor's product (e.g., an operating system, browser, or server software) contains a flaw. An attacker discovers this flaw and creates an exploit code. Before the vendor can issue a fix, the attacker deploys the exploit to gain unauthorized access, execute malicious code, or cause a denial of service.

### SOC Incident Response Program Actions

| Stage               | SOC Team Actions                                                                                                                                                                                                                                                                                                             |
| :------------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Preparation**     | **Implement $\text{EDR}$ systems** with behavioral analysis capabilities to detect the _effects_ of the exploit, even if the signature is unknown. **Maintain network segmentation** to limit the scope of compromise. **Monitor threat intelligence feeds** for early warnings of unpatched vulnerabilities.                |
| **Identification**  | **Investigate $\text{EDR}$ alerts** for unusual process execution, memory corruption, or unusual network connections. **Correlate with threat intelligence** to see if the activity matches a newly discovered zero-day exploit. **Perform deep packet inspection** to identify unusual traffic associated with the exploit. |
| **Containment**     | **Isolate the compromised systems** or the network segment containing the vulnerable software. **Implement temporary compensating controls** (e.g., custom $\text{WAF}$ rules, temporary firewall blocks for specific ports/protocols) to mitigate the exploit's impact.                                                     |
| **Eradication**     | **Apply the vendor's official patch** immediately once released. If no patch is available, **implement a configuration change** recommended by the vendor or threat intelligence (a "virtual patch") to neutralize the vulnerability. **Scan the system** for persistent malware or backdoors.                               |
| **Recovery**        | **Restore critical services** once the patch/fix is applied. **Verify that the exploit cannot be successfully launched** against the patched system. **Monitor systems** for any remaining signs of compromise for an extended period.                                                                                       |
| **Lessons Learned** | **Evaluate the time-to-detect** and time-to-contain the novel attack. **Review the process for implementing emergency/out-of-band patches**. **Enhance $\text{EDR}$ behavioral rules** to better detect this type of post-exploitation activity.                                                                             |

---

## 7. Brute Force Attack

### Description and How it Occurs

A **Brute Force Attack** is a trial-and-error method used to guess a person's username and password or an encryption key. The attacker systematically tries every possible combination until the correct one is found.

- **How it Happens:** An attacker uses automated tools (bots) to rapidly submit common passwords, or dictionary words, to a login form (e.g., $\text{SSH, RDP}$, web portal). The attack relies on the target not having adequate protections like rate limiting, account lockouts, or Multi-$\text{Factor}$ $\text{Authentication}$ ($\text{MFA}$).

### SOC Incident Response Program Actions

| Stage               | SOC Team Actions                                                                                                                                                                                                                                                                |
| :------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Preparation**     | **Enforce strong password policies** and $\text{MFA}$ for all services. **Implement $\text{rate}$ $\text{limiting}$** on all login pages to restrict the number of failed attempts per $\text{IP}$ address. **Configure account lockout policies** after a few failed attempts. |
| **Identification**  | **Monitor authentication logs** for a high volume of failed login attempts from a single or small group of $\text{IP}$ addresses. **Alert on account lockouts**. **Investigate any successful logins** that immediately follow a sequence of failed attempts.                   |
| **Containment**     | **Block the source $\text{IP}$ address** at the firewall/load balancer. **Reset the password** for any account that was successfully compromised. **Enable $\text{MFA}$** for the target account and service, if not already enabled.                                           |
| **Eradication**     | **Ensure that the brute force mitigation controls** (rate limiting, account lockout) are correctly configured and working on the targeted service. **Verify the compromised account** wasn't used to create backdoors or pivot to other systems.                                |
| **Recovery**        | **Confirm that the affected service** is fully available and the login functionality is working correctly post-mitigation. **Verify that the compromised account** has a new strong password and $\text{MFA}$ enabled.                                                          |
| **Lessons Learned** | **Review the effectiveness of the rate limiting** and lockout settings. **Audit systems** to ensure $\text{MFA}$ is universally enforced where possible. **Identify and disable** any unnecessary internet-facing services.                                                     |

---

## 8. Man-in-the-Middle ($\text{MITM}$) Attack

### Description and How it Occurs

A **Man-in-the-Middle ($\text{MITM}$) Attack** is an attack where the attacker secretly relays and possibly alters the communication between two parties who believe they are directly communicating with each other. The attacker inserts themselves into the communication channel.

- **How it Happens:** The attacker intercepts network traffic, often by tricking a victim's device into connecting through their system (e.g., $\text{ARP}$ $\text{spoofing}$ on a local network, $\text{DNS}$ $\text{spoofing}$, or setting up a malicious $\text{Wi}$-$\text{Fi}$ hotspot). Once positioned, the attacker can sniff data, steal credentials (especially if $\text{HTTPS}$ isn't enforced), or alter the content of the communication.

### SOC Incident Response Program Actions

| Stage               | SOC Team Actions                                                                                                                                                                                                                                                                                       |
| :------------------ | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Preparation**     | **Enforce the use of $\text{HTTPS}$** (end-to-end encryption) for all web traffic. **Use $\text{VPNs}$** for remote access and use on untrusted networks (e.g., public $\text{Wi}$-$\text{Fi}$). **Implement network monitoring** to detect $\text{ARP}$ $\text{spoofing}$ and $\text{DNS}$ anomalies. |
| **Identification**  | **$\text{Analyze network traffic}$** for signs of $\text{ARP}$ cache poisoning, sudden changes in default gateways, or unauthorized certificates being used for encrypted traffic. **Detect unusual $\text{DNS}$ query responses**. **Verify SSL/TLS certificate warnings** reported by users.         |
| **Containment**     | **Shut down the compromised network segment** (e.g., the $\text{Wi}$-$\text{Fi}$ access point). **Clear $\text{ARP}$ caches** on affected devices. **Block the attacker's $\text{MAC}$ address** at the network switch/router. **Force users to use a trusted, internal network**.                     |
| **Eradication**     | **Inspect network infrastructure** (switches, routers) to ensure configurations are secure and no unauthorized devices are present. **Patch any vulnerable network protocols** (like $\text{ARP}$) by using $\text{Dynamic}$ $\text{ARP}$ $\text{Inspection}$ ($\text{DAI}$).                          |
| **Recovery**        | **Instruct all potentially affected users** to immediately change their passwords for all services accessed during the $\text{MITM}$ period. **Monitor network traffic** closely to confirm the attacker is no longer active on the network.                                                           |
| **Lessons Learned** | **Review network access controls** and physical security of network closets. **Enhance network monitoring** to automatically detect and respond to $\text{ARP}$ $\text{spoofing}$. **Reinforce $\text{VPN}$ usage** policy for remote work.                                                            |

---

## 9. Cloud Misconfiguration

### Description and How it Occurs

**Cloud Misconfiguration** refers to security flaws introduced due to improperly configured cloud services (e.g., $\text{AWS}$ $\text{S3}$ buckets, $\text{Azure}$ storage accounts, $\text{Kubernetes}$ clusters). These are often the result of human error, poor visibility, or ignoring default settings.

- **How it Happens:** A developer sets an $\text{AWS}$ $\text{S3}$ bucket to be **"Publicly Accessible"** when it contains sensitive data. A security group is configured to allow $\text{SSH}$ ($\text{port}$ 22) or $\text{RDP}$ ($\text{port}$ 3389) access from **$0.0.0.0/0$** (the entire internet). Or, $\text{logging}$ and $\text{monitoring}$ are disabled, making it impossible to audit access. This unintentionally exposes resources and data to the public.

### SOC Incident Response Program Actions

| Stage               | SOC Team Actions                                                                                                                                                                                                                                                                                                                                                                   |
| :------------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Preparation**     | **Implement $\text{Cloud}$ $\text{Security}$ $\text{Posture}$ $\text{Management}$ ($\text{CSPM}$) tools** for continuous auditing of cloud resources. **Enforce $\text{Infrastructure}$ $\text{as}$ a $\text{Code}$ ($\text{IaC}$) templates** with built-in security controls. **Define and enforce standard secure configurations** (e.g., all storage buckets must be private). |
| **Identification**  | **$\text{CSPM}$ tool generates an alert** on a detected public resource or overly permissive firewall rule. **Review cloud access logs** ($\text{CloudTrail, Azure Activity Logs}$) to determine if unauthorized access or data exfiltration occurred. **Confirm the sensitive nature** of the exposed data.                                                                       |
| **Containment**     | **Immediately restrict access** to the misconfigured resource (e.g., change the $\text{S3}$ bucket permission from $\text{Public}$ to $\text{Private}$). **Revoke the overly permissive $\text{IAM}$ $\text{Role/User}$** that created the misconfiguration. **Block any suspicious $\text{IP}$ activity** observed in the logs.                                                   |
| **Eradication**     | **Re-configure the service** to meet the established secure baseline. **Audit the environment** for any other identical misconfigurations. **Use $\text{IaC}$ tools** to enforce the correct state and prevent manual override.                                                                                                                                                    |
| **Recovery**        | **Verify the misconfigured resource** is fully operational and compliant with the secure baseline. **Check for data integrity** if data modification was possible. **Restore data** from backups if data was deleted or corrupted.                                                                                                                                                 |
| **Lessons Learned** | **Automate the deployment of the $\text{CSPM}$ fix** for similar misconfigurations. **Mandate security review** for all new cloud service deployments. **Integrate security checks** into the $\text{CI/CD}$ pipeline to prevent deployment of insecure configurations.                                                                                                            |

---

## 10. Cross-Site Scripting ($\text{XSS}$)

### Description and How it Occurs

**Cross-Site Scripting ($\text{XSS}$)** is a client-side code injection vulnerability that allows an attacker to inject malicious code (usually $\text{JavaScript}$) into a web page viewed by other users. This code is then executed by the victim's browser.

- **How it Happens:** An attacker injects a script into a vulnerable web application, typically through a comment box, forum post, or search field. When another user views that page, their browser executes the script. The script can steal session cookies (leading to session hijacking), redirect the user to a malicious site, or capture keystrokes.

### SOC Incident Response Program Actions

| Stage               | SOC Team Actions                                                                                                                                                                                                                                                                                                                            |
| :------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Preparation**     | **Train developers** to **sanitize or escape all user input** before rendering it in the browser. **Implement a $\text{Content}$ $\text{Security}$ $\text{Policy}$ ($\text{CSP}$)** header on the web application to control which sources the browser can load content from. **Use a $\text{WAF}$** to filter known $\text{XSS}$ payloads. |
| **Identification**  | **$\text{WAF}$ or application security scanner generates an alert** on a suspicious input pattern (e.g., containing $\text{<script>}$ tags). **Inspect the application logs** to find the specific input field and the malicious payload. **Check for reports** of session hijacking or unauthorized redirects from users.                  |
| **Containment**     | **Immediately block the source $\text{IP}$ address** and the user account responsible for the injection. **Remove the malicious script** from the database or the page content. **Block the specific $\text{URL}$/route** that is being exploited at the $\text{WAF}$.                                                                      |
| **Eradication**     | **Fix the underlying code vulnerability** by properly **escaping** or **validating** the input. **Patch the vulnerable application** with the fixed code. **Check for and neutralize** any long-term persistence mechanisms the script may have established.                                                                                |
| **Recovery**        | **Force all active users to log out** and delete their session cookies to clear any compromised sessions. **Restore the application** to full functionality. **Monitor application logs** for repeated $\text{XSS}$ attempts.                                                                                                               |
| **Lessons Learned** | **Review the $\text{CSP}$** to ensure it is configured for maximum security (e.g., using $\text{nonces}$). **Mandate $\text{XSS}$ vulnerability scanning** before every major application release. **Improve developer training** on output encoding.                                                                                       |
