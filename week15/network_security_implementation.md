
# Network Security Implementation

## a. Firewall Rules to Restrict Network Traffic

### Implementation
- Configured firewall rules to restrict inbound and outbound traffic.
- Allowed only essential services such as SSH (port 22), HTTP/HTTPS (ports 80/443), and DNS (port 53).
- Blocked all unnecessary ports and protocols by default (default deny policy).

### Example Configuration (Linux `iptables`)
```bash
# Allow SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow HTTP & HTTPS
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow DNS
iptables -A INPUT -p udp --dport 53 -j ACCEPT

# Drop all other traffic
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
```

### Rationale
- Minimizes the attack surface by blocking non-essential ports.
- Ensures only necessary services are accessible, reducing the risk of exploitation.

---

## b. IDS/IPS Deployment

### Open-Source Solution Chosen
- **Snort** (or **Suricata**) as the IDS/IPS solution.

### Installation (Ubuntu Example)
```bash
sudo apt-get update
sudo apt-get install snort -y
```

### Configuration
- Configured Snort with community rules to detect known threats.
- Set up inline mode for IPS functionality to block malicious traffic in real-time.
- Logs and alerts are stored in `/var/log/snort/`.

### Example Snort Command
```bash
snort -A console -q -c /etc/snort/snort.conf -i eth0
```

### Rationale
- Provides real-time monitoring and alerting for suspicious activities.
- Detects and prevents intrusion attempts such as port scans, brute force attacks, and known exploits.

---

## c. Documentation of Implementation

### Steps Followed
1. Defined network access requirements and identified necessary services.
2. Implemented firewall rules using `iptables` with a default-deny policy.
3. Installed Snort IDS/IPS and applied community rules.
4. Tested detection by simulating port scans and brute force attempts.
5. Monitored logs and fine-tuned rules for reducing false positives.

### Benefits
- Improved network security through layered defense (firewall + IDS/IPS).
- Real-time threat detection and prevention.
- Detailed logging aids in forensic analysis and incident response.

---

## Conclusion
The combination of firewall rules and IDS/IPS provides strong perimeter defense and internal monitoring. The firewall restricts unnecessary traffic, while Snort/Suricata detects and blocks threats in real-time, ensuring a secure and resilient network environment.
