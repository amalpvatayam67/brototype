# Incident Investigation Report

**Report Title**: 2008 Data Breach Investigations Report  
**Prepared by**: Verizon Business Risk Team  
**Based on**: Over 500 forensic engagements from 2004–2007 :contentReference[oaicite:2]{index=2}  
**Purpose**: To extract key trends, root-causes, attack vectors and recommendations that organisations can use to understand and prevent data-breaches.

---

## 1. Executive Summary

- 73% of breaches were caused by external sources. :contentReference[oaicite:3]{index=3}
- 18% were caused by insiders. :contentReference[oaicite:4]{index=4}
- 39% involved a partner in the chain (vendor / business-partner) as the breach source. :contentReference[oaicite:5]{index=5}
- Most breaches could have been prevented by **reasonable controls**: 87% of them were considered avoidable. :contentReference[oaicite:6]{index=6}
- Many organisations did _not know where all their data was_. Data the victim did _not know was on the system_ appeared in 66% of the incidents. :contentReference[oaicite:7]{index=7}
- A large portion of breaches were neither extremely difficult nor highly targeted: 15% fully targeted, 39% random opportunistic, 46% directed opportunistic. :contentReference[oaicite:8]{index=8}

---

## 2. Investigation Methodology

- Cases cover 2004-2007 timeframe, drawn from the Verizon Business Investigative Response team’s engagements. :contentReference[oaicite:9]{index=9}
- Created a repository of hundreds of standard data-points per case (metrics) once investigations concluded. :contentReference[oaicite:10]{index=10}
- Data includes tens of thousands of data points across 500+ investigations, covering more than 230 million compromised records. :contentReference[oaicite:11]{index=11}
- Note: The dataset is subject to selection bias (only those cases where Verizon was engaged). :contentReference[oaicite:12]{index=12}

---

## 3. Demographics & Victim Profile

### 3.1 Industries

- Retail: 35% :contentReference[oaicite:13]{index=13}
- Food & Beverage: 20% :contentReference[oaicite:14]{index=14}
- Financial Services: 14% :contentReference[oaicite:15]{index=15}
- Technology/Services: 13% :contentReference[oaicite:16]{index=16}
- Other (Education, Government, Manufacturing etc) smaller proportions. :contentReference[oaicite:17]{index=17}

### 3.2 Organisation size

- 11–100 employees: 30% :contentReference[oaicite:18]{index=18}
- 101–1,000: 22% :contentReference[oaicite:19]{index=19}
- 1,001–10,000: 26% :contentReference[oaicite:20]{index=20}
- 10,000–100,000: 14% :contentReference[oaicite:21]{index=21}
- > 100,000: 3% :contentReference[oaicite:22]{index=22}  
  > **Interpretation**: Breaches happened across all sizes of organisations — small to very large — indicating that size alone doesn’t guarantee immunity.

---

## 4. Source of Breach – Who & How

### 4.1 Threat sources

- External: ≈ 73% :contentReference[oaicite:23]{index=23}
- Internal (insider): ≈ 18% :contentReference[oaicite:24]{index=24}
- Partner (third-party/vendor): ≈ 39% :contentReference[oaicite:25]{index=25}  
  Note that percentages sum to more than 100% because some incidents involved multiple sources (e.g., partner account compromised leading to external attacker). :contentReference[oaicite:26]{index=26}

### 4.2 Impact by source

- Median records compromised: External ~30,000; Internal ~375,000; Partner ~187,500. :contentReference[oaicite:27]{index=27}
  - Meaning: While external breaches were more frequent, insider and partner breaches tended to be larger in impact (more records).

### 4.3 Insider breakdown

- Roles implicated: IT Administrators ~50%, Employees ~41% :contentReference[oaicite:28]{index=28}  
  **Interpretation**: Insider threats may be less frequent, but when they occur, they can cause large scale damage due to access/privileges.

### 4.4 Partner/vendor involvement

- 57% of partner-involved cases were via partner assets or connections being compromised. :contentReference[oaicite:29]{index=29}
- 21% of partner-related breaches where the partner was anonymous (unspecified) in terms of the exact person. :contentReference[oaicite:30]{index=30}  
  **Interpretation**: Organisations must treat their supply-chain and partner network as part of their threat surface.

---

## 5. Threat Categories and Attack Pathways

### 5.1 Threat categories (contributing factors)

- Hacking: 59% :contentReference[oaicite:31]{index=31}
- Error: 62% :contentReference[oaicite:32]{index=32}
- Malcode (malicious code): 31% :contentReference[oaicite:33]{index=33}
- Deceit (e.g., phishing/spoofing): 10% :contentReference[oaicite:34]{index=34}
- Physical: 15% :contentReference[oaicite:35]{index=35}

### 5.2 Attack difficulty

- None: 3% :contentReference[oaicite:36]{index=36}
- Low: 52% :contentReference[oaicite:37]{index=37}
- Moderate: 28% :contentReference[oaicite:38]{index=38}
- High: 17% :contentReference[oaicite:39]{index=39}  
  **Interpretation**: Most breaches were relatively low-to-moderate difficulty for attackers — meaning many were avoidable with basic controls.

### 5.3 Targeted vs Opportunistic

- Fully targeted: 15% :contentReference[oaicite:40]{index=40}
- Opportunistic (Random): 39% :contentReference[oaicite:41]{index=41}
- Opportunistic (Directed): 46% :contentReference[oaicite:42]{index=42}  
  **Interpretation**: Majority of breaches were opportunistic rather than deeply targeted, reinforcing that organisations should not assume “we aren’t important enough to be targeted”.

### 5.4 Common attack pathways

- Remote access and control: 42% :contentReference[oaicite:43]{index=43}
- Web application: 34% :contentReference[oaicite:44]{index=44}
- Internet-facing systems: 24% :contentReference[oaicite:45]{index=45}
- Wireless network: 9% :contentReference[oaicite:46]{index=46}
- Physical access: 21% :contentReference[oaicite:47]{index=47}  
  **Interpretation**: Remote access (vendor/admin accounts) and web apps/Internet-facing systems represent major Entry Points into organisations.

---

## 6. Data & Asset Considerations

- 66% of breaches involved data the victim did _not know_ was on the system. :contentReference[oaicite:48]{index=48}
- 75% of breaches were _not discovered by the victim_ organisation. :contentReference[oaicite:49]{index=49}  
  **Interpretation**: Inventory and visibility of both data and systems is critical. Hidden or unmonitored assets are a consistent risk.
- For vulnerabilities exploited: In almost all cases where a known vulnerability was used, patching had been available **for 6 months or more**. :contentReference[oaicite:50]{index=50}  
  **Interpretation**: Many breaches could have been avoided with timely patch management.

---

## 7. Root Causes & Contributing Factors

### 7.1 Access / Privilege mis-use

- Insider misuse and partner access issues represent a significant risk due to privilege.

### 7.2 Configuration & process failures

- Omission (control not implemented) represented 79% of error-type cases. :contentReference[oaicite:51]{index=51}
- Misconfiguration in 15% of error cases. :contentReference[oaicite:52]{index=52}

### 7.3 Vendor / Partner ecosystem vulnerabilities

- Many breaches originate via vendor credentials or partner connections (remote access) which may be weaker than the primary organisation’s controls.

### 7.4 Lack of asset visibility & monitoring

- Organisations often don’t know what data or systems they have, making proper protection and detection very difficult.

### 7.5 Attack vector choices & defences

- Web applications, remote access, and Internet-facing systems were prominent because they are relatively exposed and often under-protected.
- Wireless and physical vectors were less frequent, but not insignificant.

---

## 8. Findings Summary

- The “typical” breach: an external actor uses remote access or a web-app vulnerability on an Internet-facing system of a small-to-mid size organisation, quickly goes undetected, exploits known vulnerabilities or misconfigurations, and exfiltrates data the organisation didn’t know existed.
- The highest impact breaches involve insiders or partners (privileged access).
- Most breaches are avoidable: with basic controls, inventory, monitoring, patching, vendor-management, access control, organisations can significantly reduce risk.

---

## 9. Recommendations (Control & Mitigation Focus)

Based on the analysis in the report, the following controls should be prioritized:

1. **Critical controls first** – Focus on the basics: inventory systems/data, patch management, secure configuration, access control, vendor/partner access.
2. **Data discovery & classification** – If you don’t know what data you have and where it is, you cannot protect it.
3. **Visibility & monitoring** – Ensure you have detection and alerting on critical systems and suspect activity (remote access, vendor accounts, data exfiltration).
4. **Vendor/partner risk management** – Extend security controls and visibility to your extended enterprise. Monitor and audit third-party access, ensure they meet your baseline.
5. **Secure the Internet-facing layer** – Web applications and remote access are major attack pathways. Ensure hardened configuration, least-privilege access, regular pen-testing, and WAF/IPS controls.
6. **Patch & vulnerability management** – Known vulnerabilities continue to be exploited. Prioritise patching of critical systems and ensure no patch backlog exceeds 6 months.
7. **Access privilege management** – Insiders and privileged partner accounts are high risk. Use least-privilege, strong authentication, session monitoring, and access reviews.
8. **Error & mis-configuration controls** – Implement process, configuration hardening, change-management and auditing.
9. **Incident detection and response capability** – Since many incidents go undetected by the victim, invest in timely detection, incident response planning, forensic readiness.
10. **Continuous improvement and governance** – Embed security into business and partner processes; ensure accountability for vendor/partner ecosystem.

---

## 10. Appendices

### A. Key Metrics

- ~230 million compromised records represented across the dataset. :contentReference[oaicite:53]{index=53}
- Attack pathway breakdown: remote access 42%, web-app 34%, internet-facing system 24% :contentReference[oaicite:54]{index=54}
- Attack difficulty: none 3%, low 52%, moderate 28%, high 17% :contentReference[oaicite:55]{index=55}
- Targeting: opportunistic vs targeted: random 39%, directed 46%, targeted 15% :contentReference[oaicite:56]{index=56}

### B. Definitions

- **External**: threat sources outside the organisation, no implied trust. :contentReference[oaicite:57]{index=57}
- **Internal (Insider)**: people within the organisation (employees, interns, IT staff) with some access or privilege. :contentReference[oaicite:58]{index=58}
- **Partner / Extended enterprise**: vendors, contractors, suppliers, third-party service providers with a business relationship and some trust/privilege. :contentReference[oaicite:59]{index=59}
- **Opportunistic (Random)**: attacker selects victim broadly, exploiting generic weakness. :contentReference[oaicite:60]{index=60}
- **Opportunistic (Directed)**: victim is known to have a particular weakness; attacker selects accordingly. :contentReference[oaicite:61]{index=61}
- **Targeted**: attacker selects the victim intentionally, then designs/executes attack accordingly. :contentReference[oaicite:62]{index=62}

---

## 11. Investigation Implications for Organisations

- The fact that most breaches are moderate difficulty and opportunistic means organisations should **not assume they’re too small or unimportant** to be attacked.
- The large role of unknown data and unmonitored assets suggests that data-discovery and asset-inventory are foundational.
- Vendor/partner risk is often underestimated — having strong controls internally is insufficient if your partners are weak links.
- Because many breaches go undetected by the victim, investment in detection and response (not just prevention) is crucial.
- Patch management and configuration issues remain perennial — known vulnerabilities exploited months after patch availability.
- Security strategy must be holistic: people, process, technology, vendor/partners, monitoring, response.

---

## 12. Conclusion

The 2008 DBIR by Verizon illustrates that data breaches are neither exotic nor require “super-hacker” skill sets — many are the result of opportunistic attackers exploiting known issues, misconfigurations, weak vendor links, or hidden data assets. The path to improvement is clear: know your data and assets, secure your perimeter and access, manage vendor risk, invest in detection and response, and maintain basic hygiene. Organisations that implement these foundational controls will likely be passed over by attackers in favour of softer targets.

---

_Report prepared for internal stakeholder review. Further customisation (organisation-specific findings, timeline of actual incident, root-cause deep-dive) would require access to the specific breach event logs, forensic data and impacted assets._
