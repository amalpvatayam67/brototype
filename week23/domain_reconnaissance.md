# Domain Reconnaissance

Domain reconnaissance is the process of discovering information about a target domain, including domain names, subdomains, DNS records, hosting details, and related digital assets. It is a foundational phase in cybersecurity assessments, penetration testing, and bug bounty hunting.

---

## 1. What Is Domain Reconnaissance?

Domain reconnaissance helps identify:

- Domain names
- Subdomains
- DNS records (A, AAAA, MX, TXT, NS, CNAME, SRV)
- Hosting providers
- Cloud assets (S3 buckets, CDN endpoints)
- Email configuration
- Technology stack
- Exposed services & admin portals

---

## 2. Techniques to Discover Domain Names & Subdomains

### **A) Certificate Transparency Logs**
Certificate Transparency (CT) logs store all SSL certificates issued publicly.

**Tools:**
- crt.sh
- Censys
- CertSpotter

Example:
```
https://crt.sh/?q=example.com
```

---

### **B) Passive Subdomain Enumeration**
Collect subdomains without sending traffic to the target.

**Tools:**
- Subfinder
- Assetfinder
- Amass (passive)
- VirusTotal
- Shodan / Censys

Example:
```
subfinder -d example.com -o passive.txt
```

---

### **C) Active Subdomain Enumeration**
Brute-force or resolve DNS directly.

**Tools:**
- Amass (active)
- Gobuster
- Ffuf

Example:
```
gobuster dns -d example.com -w subdomains.txt
```

---

### **D) DNS Bruteforce & Permutations**

**Tools:**
- DNSX
- Gotator

Example:
```
dnsx -d example.com -w wordlist.txt
```

---

### **E) Reverse DNS Lookups**
Used to find domains sharing the same IP.

**Tools:**
- Shodan
- Censys

---

### **F) ASN Enumeration**
Find entire IP ranges owned by the organization.

**Tools:**
- Amass intel
- bgp.he.net

Example:
```
amass intel -asn 13335
```

---

### **G) Cloud Asset Discovery**

**Tools:**
- cloud_enum
- S3Scanner

---

### **H) DNS Record Enumeration**

| Record | Purpose | Use |
|--------|---------|------|
| A | IPv4 address | Web server |
| AAAA | IPv6 address | Web server |
| MX | Mail server | Email routing |
| TXT | SPF/DKIM/DMARC | Email security |
| CNAME | Alias | Subdomain mapping |
| NS | Nameservers | DNS routing |
| SRV | Services | VoIP, LDAP, SIP |

Example:
```
dig any example.com
dnsrecon -d example.com
```

---

## 3. Step-by-Step Domain Recon Workflow

### Step 1 — Passive enumeration
```
subfinder -d example.com -o passive.txt
amass enum -passive -d example.com -o amass.txt
```

### Step 2 — Combine & clean
```
cat *.txt | sort -u > all_subdomains.txt
```

### Step 3 — Validate live subdomains
```
dnsx -l all_subdomains.txt -resp -o live.txt
```

### Step 4 — Active brute-force
```
gobuster dns -d example.com -w wordlist.txt
```

### Step 5 — Check DNS configuration
```
dig mx example.com
dig txt example.com
```

### Step 6 — Technology fingerprinting
```
whatweb https://sub.example.com
```

### Step 7 — Detect subdomain takeovers
```
subjack -w live.txt -o takeovers.txt
```

---

## 4. Why Domain Reconnaissance Matters

- Reveals forgotten or unused assets  
- Identifies subdomain takeover risks  
- Maps external attack surface  
- Supports compliance, auditing, and vulnerability management  

---

## 5. Recommended Tools Summary

| Category | Tools |
|---------|--------|
| Passive Enumeration | Subfinder, Assetfinder, Amass |
| Active Enumeration | Gobuster, Ffuf, Amass |
| DNS Recon | dnsrecon, dig, nslookup |
| Takeover Detection | subjack, nuclei |
| Cloud Discovery | cloud_enum, S3Scanner |
| OSINT | Shodan, Censys |

---


