# IP Addressing, Subnetting, CIDR, MAC Addresses, and ARP
*A concise, exam‑ready and practitioner‑friendly guide*

> **Scope**  
> a) IPv4 & IPv6 addressing schemes, subnetting, and CIDR notation  
> b) MAC addresses, ARP, and MAC address spoofing (with a defensive focus)  
> c) Practical commands, examples, and quick-reference tables

---

## 1) Networking Layers at a Glance (OSI vs TCP/IP)

- **Layer 3 (Network):** IP (IPv4/IPv6), routing, subnets, CIDR. *Logical addressing.*  
- **Layer 2 (Data Link):** Ethernet, **MAC addresses**, switches. *Physical/port-based delivery on a LAN.*  
- **L2 ↔ L3 glue:** **ARP** (IPv4) and **NDP** (IPv6) resolve L3 → L2 next-hop addresses.

```
App ────────────────────────────────────────────────
Transport (TCP/UDP) ────────────────────────────────
Network (IPv4/IPv6, routing, ICMP) ────────────────
Data Link (Ethernet, 802.1Q VLANs, MAC) ───────────
Physical (copper/fiber/wifi) ──────────────────────
```

---

## 2) IPv4 Addressing & Subnetting

### 2.1 IPv4 Basics
- **32-bit** address, shown in **dotted‑decimal**: `a.b.c.d` (e.g., `192.168.1.10`).  
- Each octet: **0–255**. Example binary:
```
192     . 168     . 1       . 10
11000000 . 10101000 . 00000001 . 00001010
```

### 2.2 Private & Special Ranges
- **Private** (RFC 1918):  
  - `10.0.0.0/8`  
  - `172.16.0.0/12`  
  - `192.168.0.0/16`
- **Loopback:** `127.0.0.0/8` (commonly `127.0.0.1`)  
- **APIPA (link-local):** `169.254.0.0/16`  
- **Multicast:** `224.0.0.0/4`  
- **Broadcast:** last address of a subnet (e.g., `/24` → `.255`).

### 2.3 CIDR Notation
- **CIDR** = *Classless Inter‑Domain Routing*.  
- Notation: `IP/PrefixLength` (e.g., `192.168.1.10/24`).
- **Prefix length** = number of network bits; **host bits** = 32 − prefix.
- Usable hosts per subnet (IPv4): `2^(host_bits) - 2` (network & broadcast excluded).

#### Quick Table
| CIDR | Mask            | Hosts usable | Subnet size |
|-----:|-----------------|-------------:|------------:|
| /30  | 255.255.255.252 | 2            | 4           |
| /29  | 255.255.255.248 | 6            | 8           |
| /28  | 255.255.255.240 | 14           | 16          |
| /27  | 255.255.255.224 | 30           | 32          |
| /26  | 255.255.255.192 | 62           | 64          |
| /25  | 255.255.255.128 | 126          | 128         |
| /24  | 255.255.255.0   | 254          | 256         |
| /23  | 255.255.254.0   | 510          | 512         |
| /22  | 255.255.252.0   | 1022         | 1024        |

### 2.4 Subnetting — Step‑by‑Step Example
**Q:** Find the network, broadcast, and host range for `192.168.1.130/26`.

- `/26` → host bits = 6 → **subnet size** = `2^6 = 64` addresses.  
- Subnet blocks in a `/26` within `192.168.1.0/24`:  
  `192.168.1.0`, `.64`, `.128`, `.192`
- **Network** containing `.130` = `192.168.1.128`  
- **Broadcast** = `192.168.1.191`  
- **Usable range** = `192.168.1.129` – `192.168.1.190`

### 2.5 Wildcard Masks (ACLs/Firewalls)
- **Wildcard** = inverse of subnet mask.  
  - `/24` mask `255.255.255.0` → wildcard `0.0.0.255`  
  - Useful in ACL syntax (e.g., Cisco) to match address blocks.

### 2.6 VLSM & Summarization
- **VLSM**: Allocate different prefix lengths per subnet (e.g., `/28` for 10 hosts, `/26` for 50 hosts) to reduce waste.  
- **Route summarization (supernetting)**: Aggregate routes (e.g., four `/24`s → one `/22`) to shrink routing tables.

---

## 3) IPv6 Addressing

### 3.1 IPv6 Basics
- **128-bit** addresses, written in **hex** as 8 **hextets**: `2001:0db8:0000:0000:0000:ff00:0042:8329`
- **Zero compression** rules:
  - Leading zeros in a hextet can be dropped: `0db8 → db8`
  - One run of consecutive `:0000:` can be replaced with `::` (only **once**):  
    `2001:db8::ff00:42:8329`

### 3.2 Important IPv6 Prefixes
- **Global Unicast:** `2000::/3`  
- **Link‑local:** `fe80::/10` (auto on each interface; not routed)  
- **Unique Local (ULA):** `fc00::/7` (like IPv6 private)  
- **Multicast:** `ff00::/8`  
- **Loopback:** `::1/128`

### 3.3 Interface IDs & EUI‑64
- A `/64` subnet is standard: **first 64 bits** network, **last 64 bits** interface ID.  
- Interface ID can be derived from MAC using **EUI‑64** (with `ff:fe` inserted and the **U/L bit** toggled), or set randomly for privacy.

### 3.4 Address Configuration
- **SLAAC** (Stateless Autoconfig): host builds its own address from router **RA** messages.  
- **DHCPv6**: server assigns addresses/options.  
- **NDP** (Neighbor Discovery) replaces ARP in IPv6.

---

## 4) MAC Addresses (Layer 2)

### 4.1 Structure
- **48-bit** (6 bytes), shown as `aa:bb:cc:dd:ee:ff` or `aa-bb-cc-dd-ee-ff`.  
- First 24 bits = **OUI** (vendor), last 24 bits = NIC‑specific.  
- **I/G bit** (LSB of first byte): 0 = unicast, 1 = multicast.  
- **U/L bit** (second LSB of first byte): 0 = globally unique (factory), 1 = **locally administered**.

### 4.2 Why MACs Matter
- Switches build a **MAC address table** (CAM) mapping `MAC ⇄ port`.  
- Frames on a LAN are delivered using MACs, *not* IPs.

---

## 5) ARP (Address Resolution Protocol)

### 5.1 What ARP Does (IPv4 only)
- Maps **IPv4** addresses to **MAC** addresses.  
- When a host wants to send to `192.168.1.5`, it broadcasts:  
  “Who has **192.168.1.5**? Tell **192.168.1.10**.”  
- The owner replies with its **MAC**. Entry is cached in the **ARP table**.

### 5.2 ARP Types & Behaviors
- **ARP Request/Reply** (normal resolution)  
- **Gratuitous ARP**: host announces/updates its own IP→MAC mapping (IP conflict detection, failover VIPs).  
- **Proxy ARP**: router answers on behalf of another host to bridge subnets (rarely used now).

### 5.3 IPv6 Equivalent
- **NDP** (ICMPv6 RS/RA/NS/NA) performs similar functions without ARP.

---

## 6) MAC Address Spoofing & ARP Poisoning (Defensive View)

> **Ethics first:** The following is for controlled labs and defensive understanding only. Unauthorized network attacks are illegal and can cause service disruption.

### 6.1 MAC Spoofing
- **What**: Changing the NIC’s MAC to a different (often locally administered) value.  
- **Why attackers try it**: Bypass MAC‑based filters, re‑authenticate captive portals, impersonate devices.  
- **Legitimate uses**: Privacy, lab testing, failover of VIPs, hot‑swap network hardware.

**Defense:**
- **802.1X** port‑based authentication (EAP).  
- **Switch Port Security** (limit allowed MACs, sticky MAC).  
- Monitor **duplicate MAC** events on switches/WLCs.

### 6.2 ARP Poisoning / Spoofing
- **What**: Sending forged ARP replies to update victims’ ARP caches with the attacker’s MAC for a target IP (e.g., the gateway), enabling **Man‑in‑the‑Middle**.  
- **Impact**: Traffic interception, session hijack, DNS spoofing, credential theft.

**Defense:**
- **Dynamic ARP Inspection (DAI)** on switches (ties to **DHCP Snooping**).  
- Prefer **static ARP** for critical hosts (servers, gateways) where feasible.  
- Enforce **segmentation** (VLANs), **host firewalls**, and **TLS** end‑to‑end.  
- Use **IPv6 with RA Guard/NDP inspection** where appropriate.  
- **Detect** with IDS/IPS or tools that alert on ARP table churn/inconsistencies.

---

## 7) Practical Commands & Tools

> Replace interface names and IPs for your OS/environment.

### 7.1 View/Manage IP & Neighbors
```bash
# Linux
ip addr              # show IPv4/IPv6 addresses
ip route             # routing table
ip neigh             # neighbor (ARP/NDP) cache
arp -a               # ARP table (legacy net-tools)
ping 192.168.1.1     # reachability (ICMP)
traceroute 8.8.8.8   # path to destination
```

```powershell
# Windows PowerShell
Get-NetIPAddress
Get-NetRoute
arp -a
Test-Connection 8.8.8.8 -Count 4
tracert 8.8.8.8
```

### 7.2 Subnet Calculators
```bash
# Linux packages (any one)
ipcalc 192.168.1.130/26
sipcalc 10.10.10.0/23
```

### 7.3 Packet Capture & Filters (Wireshark/Tshark)
- **ARP only:** `arp`
- **IPv6 NDP:** `icmpv6 && (ndp || neighbor || router)`
- **Host traffic:** `ip.addr == 192.168.1.10`
- **Gateway ARP:** `arp.dst.proto_ipv4 == 192.168.1.1`

### 7.4 Lab‑Safe MAC Change (Example: Linux)
```bash
# CAUTION: Do this only on lab gear or with permission
sudo ip link set dev eth0 down
sudo ip link set dev eth0 address 02:11:22:33:44:55   # locally administered (U/L bit set)
sudo ip link set dev eth0 up
ip link show dev eth0 | grep link/ether
```

> On Windows, some NIC drivers allow spoofing in adapter **Advanced** properties; otherwise use PowerShell/WMI or vendor tools. Not all drivers permit MAC changes.

---

## 8) Worked IPv4 Subnetting Exercises

### Exercise A
**Given:** `10.20.8.0/22`  
- **Subnet size:** `2^(32-22) = 1024` addresses, **usable** = 1022  
- **Range:** `10.20.8.0 – 10.20.11.255`  
- **Network:** `10.20.8.0`  
- **Broadcast:** `10.20.11.255`  
- **Usable hosts:** `10.20.8.1 – 10.20.11.254`

### Exercise B
**Given host:** `172.16.19.77/28`  
- `/28` block size = 16 → subnets start at `.0, .16, .32, .48, .64, .80, ...`  
- **Network:** `172.16.19.64`  
- **Broadcast:** `172.16.19.79`  
- **Usable:** `172.16.19.65 – 172.16.19.78`

### Exercise C (Summarization)
Aggregate `192.168.12.0/24`–`192.168.15.0/24` → **`192.168.12.0/22`**

---

## 9) IPv6 Quick‑Fire Exercises

### Exercise D
**Shorten:** `2001:0db8:0000:0000:0000:0000:0042:0001`  
→ `2001:db8::42:1`

### Exercise E
**Type:** `fe80::1` → **Link‑local** (valid only on the local link, requires zone index like `%eth0` on some OSes).

### Exercise F
**Prefix decision:** Standard LAN → **`/64`** (supports SLAAC and best interoperability).

---

## 10) Security Checklist (Blue‑Team Quick Wins)
- Enforce **TLS** everywhere (even if ARP/NDP is attacked, payload stays encrypted).  
- Enable **DHCP Snooping** and **DAI** on managed switches; log violations.  
- Use **802.1X** for device authentication; disable unused ports.  
- Segment networks with **VLANs**; minimize L2 broadcast domains.  
- Monitor for **duplicate IP/MAC** and ARP storms; set alert thresholds.  
- Prefer **static IPs/ARP** only for crown‑jewel systems where viable.  
- Keep **firmware** (switch/Wi‑Fi) updated to get NDP/ARP guard features.

---

## 11) Glossary
- **CIDR**: Classless notation `IP/prefix` expressing network bits.  
- **EUI‑64**: Method to form a 64‑bit interface ID from a 48‑bit MAC.  
- **NDP**: IPv6 Neighbor Discovery Protocol (RS/RA/NS/NA/Redirect).  
- **OUI**: Organizationally Unique Identifier (first 24 bits of MAC).  
- **SLAAC**: Stateless Address Autoconfiguration for IPv6.  
- **VLSM**: Variable Length Subnet Masking (different masks per subnet).

---

## 12) References & Further Reading
- RFC 1918 (IPv4 private addresses)  
- RFC 4632 (CIDR for IPv4)  
- RFC 4291 (IPv6 addressing architecture)  
- RFC 4861 (Neighbor Discovery for IPv6)  
- Vendor docs: Cisco “IP Addressing and Subnetting”, Microsoft “IP Fundamentals”, Linux `iproute2` manpages.

---
