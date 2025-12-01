# Nmap Host Discovery & Port Scanning

This document covers:

- How to learn and practice using Nmap for host discovery and port scanning
- Identification of common scan types: **TCP SYN**, **TCP Connect**, **UDP**, and **Service/Version detection**

---

## 1. Introduction to Nmap

**Nmap (Network Mapper)** is a powerful open‑source tool used for:

- Discovering live hosts
- Enumerating open ports
- Identifying running services
- Detecting operating systems
- Running automated scripts for vulnerability detection

It is essential for cybersecurity professionals, SOC analysts, penetration testers, and network administrators.

---

## 2. Host Discovery Techniques

Host discovery determines which machines on a network are alive.

### **A) Ping Scan (No port scan)**

```
nmap -sn 192.168.1.0/24
```

- Sends ICMP Echo Requests
- Faster and non-intrusive

---

### **B) ARP Scan (Best for LAN environments)**

```
nmap -PR 192.168.1.0/24
```

- Very accurate on local networks
- Uses ARP requests instead of ICMP

---

### **C) Disable Ping (Useful when ICMP is blocked)**

```
nmap -Pn example.com
```

- Treats all hosts as online
- Can still scan ports

---

## 3. Port Scanning Techniques

Nmap supports multiple scan types depending on privileges, stealth, and depth of analysis.

---

## **A) TCP SYN Scan (`-sS`)**

Also known as the “half‑open” or stealth scan.

```
nmap -sS example.com
```

### ✔ Advantages:

- Stealthy
- Fast
- Default when run as root

### ❗ Notes:

- Requires raw socket privileges

---

## **B) TCP Connect Scan (`-sT`)**

Completes the full TCP handshake.

```
nmap -sT example.com
```

### ✔ Advantages:

- Works without root privileges

### ❗ Disadvantages:

- More detectable in logs

---

## **C) UDP Scan (`-sU`)**

Used to discover UDP services.

```
nmap -sU example.com
```

### ✔ Finds services like:

- DNS (53)
- SNMP (161)
- NTP (123)

### ❗ Notes:

- Slow due to UDP behavior
- May produce false positives

---

## 4. Service & Version Detection

Identify software versions and running services.

### **A) Basic version detection**

```
nmap -sV example.com
```

### **B) Aggressive version detection**

```
nmap -A example.com
```

Includes:

- Version detection
- OS detection
- Script scanning
- Traceroute

### **C) OS Detection Only**

```
nmap -O example.com
```

---

## 5. Useful Nmap Scan Combinations

### **A) Full TCP SYN + Version detection**

```
nmap -sS -sV example.com
```

### **B) Fast Scan (Top 100 ports)**

```
nmap -F example.com
```

### **C) Scan all ports**

```
nmap -p- example.com
```

### **D) Scan specific ports**

```
nmap -p 22,80,443 example.com
```

---

## 6. Nmap Scripting Engine (NSE) Basics

Run automation scripts for enumeration or vulnerability checks.

### **List available scripts**

```
ls /usr/share/nmap/scripts
```

### **Run vulnerability scripts**

```
nmap --script=vuln example.com
```

### **Run specific script**

```
nmap --script=http-enum -p 80 example.com
```

---

## 7. Practice Exercises

### **Exercise 1 — Discover live hosts**

```
nmap -sn 192.168.1.0/24
```

### **Exercise 2 — Stealth port scan**

```
nmap -sS -p- 192.168.1.10
```

### **Exercise 3 — Service detection**

```
nmap -sV scanme.nmap.org
```

### **Exercise 4 — UDP Scan**

```
nmap -sU scanme.nmap.org
```

### **Exercise 5 — Aggressive scan**

```
nmap -A scanme.nmap.org
```

---

## 8. Summary Table of Scan Types

| Scan Type         | Nmap Option | Purpose                    |
| ----------------- | ----------- | -------------------------- |
| Ping Scan         | `-sn`       | Host discovery             |
| SYN Scan          | `-sS`       | Stealthy TCP scan          |
| TCP Connect       | `-sT`       | Full TCP handshake         |
| UDP Scan          | `-sU`       | UDP service enumeration    |
| Version detection | `-sV`       | Identify software versions |
| OS detection      | `-O`        | Detect operating system    |
| Aggressive scan   | `-A`        | Full analysis              |

---
