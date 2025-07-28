# 🛡️ VPNs vs Proxies vs Tor: Online Privacy and Security

---

## Visual Overview

![VPN vs Proxy vs Tor](./images/vpn_tor_proxy.png)

---

## 🔹 VPN (Virtual Private Network)

### How it Works:

A VPN encrypts all your internet traffic and routes it through a secure server, masking your IP address and location.

### Use Cases:

- Bypass geo-blocks (e.g., Netflix, BBC)
- Secure public Wi-Fi
- Hide IP from websites and ISPs
- Prevent ISP throttling

### Limitations:

- Requires trust in the VPN provider
- Paid VPNs are more reliable than free ones
- Not anonymous (VPN can log your data if not privacy-focused)

---

## 🔹 Proxy Servers

### How it Works:

A proxy acts as an intermediary between your device and the internet. It only handles traffic from specific apps (e.g., browser).

### Use Cases:

- Simple IP masking
- Bypass website blocks
- School or workplace filters

### Limitations:

- No encryption (unless using HTTPS proxy)
- Only works per-application (not system-wide)
- Logs and privacy risks on free proxies

![Proxy Diagram](https://marvel-b1-cdn.bc0a.com/f00000000310757/www.fortinet.com/content/dam/fortinet/images/cyberglossary/proxy-server-1.jpeg)

---

## 🔹 Tor (The Onion Router)

### How it Works:

Tor anonymizes your internet traffic by routing it through multiple volunteer-operated nodes. Each layer of encryption is peeled off at each hop — like an onion.

### Use Cases:

- Accessing the dark web (.onion sites)
- Journalists, activists, whistleblowers
- High-level anonymity and anti-censorship

### Limitations:

- Slower speeds due to multi-hop routing
- Some websites block Tor exit nodes
- Illegal use cases give Tor a bad reputation

![Tor Diagram](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ1fi6FUBDP09gR7Rk0LYrKtfwWbvU7mb1MQ&s)

---

## Comparison Table

| Feature           | VPN                           | Proxy                  | Tor                    |
| ----------------- | ----------------------------- | ---------------------- | ---------------------- |
| Encrypts traffic  | Yes (system-wide)             | Usually not            | Multi-layered          |
| Hides IP          | Yes                           | Yes (limited)          | Yes (multi-hop)        |
| Speed             | Fast                          | Faster (but less safe) | Slower                 |
| Anonymous?        | Partial (depends on provider) | No                     | Yes (very anonymous)   |
| Whole system?     | Yes                           | No (browser/app only)  | Yes (with Tor browser) |
| Geo-block bypass  | Great                         | Moderate               | Limited                |
| Logs by provider? | Maybe                         | Often                  | No (decentralized)     |

---

## Which One Should You Use?

| Goal                                       | Use Tool                        |
| ------------------------------------------ | ------------------------------- |
| Stream or access blocked content           | VPN                             |
| Lightweight IP masking                     | Proxy                           |
| Max anonymity (journalism, whistleblowing) | Tor                             |
| Secure public Wi-Fi                        | VPN                             |
| Combine for layered privacy                | VPN + Tor (caution: slows down) |

---

> Pro Tip: Use **VPN + Tor** if you need strong anonymity + ISP evasion, but never log in to personal accounts through Tor for full anonymity.
