# Incident Investigation Report

**Report Title**: 2015 Data Breach Investigations Report (DBIR)  
**Prepared by**: Verizon Enterprise Solutions  
**Based on**: 79,790 security incidents, 2,122 confirmed data breaches across 61 countries.
**Purpose**: To extract key trends, root-causes, attack vectors and recommendations that organisations can use to understand and prevent data-breaches.

---

## 1. Executive Summary

- The report covers nearly **80,000** security incidents and over **2,100** confirmed data breaches.
- The top three industries affected are **Public**, **Information/Technology**, and **Financial Services**.
- A striking trend: in **70%** of attacks where motive is known, there is a _secondary victim_.
- Phishing remains a major vector: ~23% of recipients open phishing emails; ~11% click on attachments.
- Known vulnerabilities dominate exploit sets: 10 CVEs accounted for ~97% of all exploits observed.
- Mobile-malware, as per this dataset, is still relatively low: the mobile device vector remains less prominent.
- The bottom line: Many breaches are the result of known vectors, longstanding vulnerabilities, and insufficient controls rather than exclusively “exotic” attacks.

---

## 2. Investigation Methodology

- Data was contributed by ~70 organisations (forensics firms, ISACs, CSIRTs, law enforcement) across 61 countries.
- Defined terms:
  - _Security incident_: Any event that compromises the confidentiality, integrity or availability of an information asset.
  - _Data breach_: A confirmed disclosure of data to an unauthorised party.
- The dataset includes large-scale incidents, across varied industries and organisation sizes (small, medium, large).
- The report uses event-classification patterns (nine major categories) to structure findings.

---

## 3. Victim Demographics & Profile

### 3.1 Industry Breakdown

- Top industries by number of incidents: Public, Information (Technology/Communications), Financial Services.
- When looking at confirmed breaches, sectors such as Manufacturing also appear high, especially due to cyber-espionage.

### 3.2 Organisation Size & Geography

- The data spans 61 countries.
- Small organisations (vs large) show up quite heavily in certain sectors (e.g., retail, accommodation) for confirmed breaches.

### 3.3 Interpretations

- No industry is immune. As the report states: “Don’t let a ‘that won’t happen to me because I’m too X’ attitude catch you napping.”
- Smaller organisations may have weaker controls, making them attractive targets (especially in certain sectors).

---

## 4. Threat Sources & Actors

- Threat actors are broadly categorised as **External**, **Internal (insider)**, and **Partner / Third-party**. Trends in proportions remain consistent with prior years.
- Notably: In many incidents the actual motive wasn’t simply the direct victim but a _secondary victim_ (e.g., compromised site used to attack another). ~70% of cases where motive is known.

### 4.1 Attack Motivations

- Motives include financial gain, espionage, disruption, etc.
- Example: Web-application attacks used as stepping stones to other targets.

### 4.2 Attack Difficulty / Strategy

- Many attacks are opportunistic (not highly targeted).
- Some pattern examples: RAM scraping (for POS systems), web app intrusion, phishing.

---

## 5. Threat Actions, Attack Vectors & Patterns

### 5.1 Dominant Attack Patterns

- The report frames nine “incident classification patterns” which cover most breaches.
  - Among highest-frequency: POS Intrusions, Crimeware, Web App Attacks, Insider Misuse, Physical Theft/Loss, Payment Card Skimmers, Denial of Service, Cyber-espionage, Miscellaneous Errors.

### 5.2 Key Findings

- **Phishing**:
  - 23% of recipients open phishing messages; 11% click attachments.
  - Median time to first click ~82 seconds.
- **Vulnerabilities**:
  - 10 CVEs accounted for ~97% of observed exploits in 2014.
  - Many exploited vulnerabilities were months or years old — patching delays remain a major risk.
- **Mobile Malware**:
  - “Mobile malware isn’t even 1% of them” in this dataset, meaning mobile hasn’t yet become a major breach vector in those incidents.
- **Detection / Compromise Time**:
  - Attackers often compromise systems within minutes.
  - Defenders still lag: the time to discovery remains significantly longer than time to compromise.

### 5.3 Industry-specific notes

- **Retail / Accommodation / Entertainment**: High incidence of POS intrusions and payment card skimmers.
- **Manufacturing / Professional services**: Higher exposure to cyber-espionage threats.

---

## 6. Assets, Data and Visibility Issues

- A key point: Many breaches involve data the victim didn’t know existed or systems the victim assumed were non-critical.
- Asset inventory, data classification, visibility into where data resides and flows is frequently weak.
- The fact that older vulnerabilities dominate exploit sets means that simple hygiene (patching, configuration) still isn’t consistently implemented.

---

## 7. Root Causes & Contributing Factors

- **Human factor**: Phishing and user behaviour remain a major contributor.
- **Lack of basic controls**: Patch-backlog, unmonitored systems, poor configuration.
- **Insider / Partner risk**: While less frequent than external, insider misuse and partner/third-party access remain significant.
- **Supply chain / secondary victimization**: E.g., a site used as pivot to another target.
- **Slow detection / response**: Attackers move fast; defenders often much slower.

---

## 8. Findings Summary

- Many incidents are **not** highly sophisticated targeted attacks — opportunistic attacks exploiting known weaknesses dominate.
- The largest impact events often involve elevated privileges (insiders / third-party access).
- The good news: A large fraction of breaches could be prevented with **basic strong controls** (visibility, patching, access management).
- The “defender detection deficit” (time to detect vs time to compromise) remains a critical gap.
- Mobile device threats, while growing in general discourse, did not dominate in this dataset — which suggests organisations may still prioritise other controls.

---

## 9. Recommendations (Control & Mitigation Focus)

1. **Inventory and classify data & assets** – Know what you have, where it is, who has access.
2. **Visibility and monitoring** – Implement around critical systems, privileged access, remote vendor/partner access.
3. **Patch and vulnerability management** – Prioritise high-risk systems; many breaches exploited old, known vulnerabilities.
4. **Access control and least-privilege** – Especially for third-party/vendor and insider access.
5. **Phishing awareness and simulation** – Human factor remains strong; training and testing are key.
6. **Incident detection and response capability** – Time to detect needs improvement to match fast compromise times.
7. **Secure internet-facing systems and POS systems** – These remain high-risk vectors.
8. **Supply chain/third-party risk management** – Treat vendors/partners as part of threat surface.
9. **Basic cyber-hygiene controls** – Many “quick wins” (80% of incidents mapped to controls that are relatively straightforward) still not fully implemented.
10. **Governance, policy and continuous improvement** – Embed security, review regularly, respond to findings.

---

## 10. Appendices

### A. Key Metrics (from report)

- 79,790 security incidents analysed.
- 2,122 confirmed data breaches.
- 61 countries represented.
- ~23% of phishing recipients opened messages; ~11% clicked on attachments.
- ~97% of observed exploits in 2014 derived from just 10 CVEs.

### B. Definitions

- **Security incident**: See section 2.
- **Data breach**: See section 2.
- **Secondary victim**: When an actor compromises one system (Victim A) in order to pivot or do damage to another target (Victim B).

---

## 11. Implications for Organisations

- Even small or mid-sized organisations cannot assume they are “too small to be targeted”.
- The fact that so many attacks exploit old vulnerabilities or simple phishing underscores the value of foundational controls.
- Detection and response capabilities must be improved — attack speed outpaces many defenders.
- Humans are the pivot point: phishing, credentials, mis-configuration. Tech alone won’t fix everything.
- The vendor/partner ecosystem matters: compromised third-party access is a major threat vector.
- Cyber-espionage, POS intrusions, web-app attacks are persistent — industry-specific vectors matter.
- Asset visibility and governance must be improved to reduce “unknown unknowns”.

---

## 12. Conclusion

The 2015 DBIR by Verizon illustrates that data-breaches are neither exotic nor require “super-hacker” skill-sets. Many are the result of opportunistic attackers exploiting known issues, mis-configurations, weak vendor links, or hidden data assets. The path to improvement is clear: know your data, secure your perimeter and access, manage vendor risk, invest in detection and response, and maintain basic hygiene. Organisations that implement these foundational controls will likely be passed over by attackers in favour of softer targets.

---

_Report prepared for internal stakeholder review. Further customisation (organisation-specific findings, timeline of actual incident, root-cause deep-dive) would require access to the specific breach event logs, forensic data and impacted assets._
