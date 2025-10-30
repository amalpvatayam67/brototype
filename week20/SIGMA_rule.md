# 🛡️ Sigma Rules: A Generic Signature Format for SIEM

Sigma is an **open and generic signature format** that allows security analysts and threat hunters to describe relevant log events in a straightforward, standardized manner. It is often called the "**YARA for logs**," as it enables the creation of platform-agnostic detection rules that can be applied across different Security Information and Event Management (SIEM) systems.

---

## What are Sigma Rules?

Sigma rules are written in **YAML** (YAML Ain't Markup Language) files and contain the logic necessary to detect suspicious, malicious, or odd behavior within log files. They essentially serve as a **common language** for threat detection logic, unifying the approach across diverse security tools.

### Application in SOC Environments

In a Security Operations Center (SOC) environment, Sigma rules play a critical role in enhancing **threat detection and response**:

* **Unified Threat Intelligence:** They allow security teams to easily share, deploy, and maintain detection logic based on the latest threat intelligence or newly discovered Indicators of Compromise (IOCs).
* **Rapid Deployment:** New threat detection logic can be written once (as a Sigma rule) and rapidly deployed across an organization's heterogeneous SIEM/security stack.
* **Threat Hunting:** Analysts use Sigma rules to hunt for specific Tactics, Techniques, and Procedures (TTPs) defined by frameworks like **MITRE ATT&CK®**.
* **Standardization:** They ensure that the same security event is detected consistently, regardless of the underlying log source or SIEM platform.

---

## Structure of a Sigma Rule

A Sigma rule is a YAML file typically containing several distinct sections that define the detection logic:

| Section | Description | Key Fields |
| :--- | :--- | :--- |
| **Metadata** | Descriptive information about the rule. | `title`, `id`, `description`, `author`, `date`, `tags` (e.g., MITRE ATT&CK mappings). |
| **Log Source** | Specifies where to look for the events. | `product` (e.g., `windows`, `linux`), `service` (e.g., `sysmon`, `powershell`). |
| **Detection** | The core logic that defines the suspicious pattern. | `selection` (field-value pairs to match), `condition` (logical combination of selections). |
| **Level** | Severity of the detected event. | `low`, `medium`, `high`, `critical`. |

### Example Rule Structure (Conceptual)

```yaml
title: Suspicious PowerShell Command
description: Detects highly suspicious keywords in PowerShell command line arguments.
logsource:
  product: windows
  service: powershell
detection:
  selection:
    - CommandLine|contains: 'IEX '
    - CommandLine|contains: 'DownloadString'
  condition: selection
level: high
```
## Standardizing Detection Queries Across SIEMs

Sigma achieves standardization by separating the detection logic from the platform-specific syntax through a two-part process:

* **Generic Signature:**
    * The detection rule is written in the generic, human-readable **YAML** format, making it completely **SIEM-agnostic**.
    * It specifies ***what*** to look for (e.g., a specific log field, value, and logical operator) rather than ***how*** to write the query.

* **Conversion Backend:**
    * Dedicated **Converters** (tools like PySigma or Uncoder.io) are used to read the generic Sigma YAML file.
    * These tools translate the generic logic into the native query language of a specific SIEM platform (e.g., Splunk's SPL, Elastic's EQL, Microsoft Sentinel's KQL).

This abstraction layer eliminates the need for security analysts to manually rewrite the same detection logic for every platform, significantly improving efficiency and consistency.

---

## Role in Effective Incident Response

Sigma rules contribute to effective security threat response by streamlining operations and providing immediate context:

* **Early and Accurate Identification:** Standardized, peer-reviewed logic reduces false positives and ensures consistent threat detection across the infrastructure.
* **Enriched Alerts:** The required metadata in the rule (e.g., MITRE TTPs and external references) automatically enriches the alert generated in the SIEM, providing crucial context.
* **Streamlined Triage:** SOC analysts have immediate context about the threat, allowing for faster and more informed **triage and incident response** actions.