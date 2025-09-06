# SSL/TLS Vulnerability Assessment — Methodology, Findings, Impact & Mitigation

**Author:** Amal P. • **Date:** 06 September 2025  
**Scope:** Scan specified domains for SSL/TLS weaknesses; document **impact**, **root causes**, **identification methods**, and **mitigations**.  
**Note:** This report includes a **ready-to-run methodology**, command examples, and a **findings template** to fill with your results.



## 1) Targets & Environment

- **Targets (fill these):**  
  - `example.com`, `api.example.com`, `mail.example.com`  
  - Add ports beyond 443 if applicable: `:443, :8443, :993 (IMAPS), :465 (SMTPS)`, etc.

- **Tester machine:** Linux/macOS recommended.

- **Tools (install latest):**
  - **Nmap** (with NSE scripts)  
  - **testssl.sh** (comprehensive TLS tester)  
  - **sslscan** (quick cipher/handshake view)  
  - **SSLyze** (Python-based analyzer)  
  - **OpenSSL** CLI (sanity checks)

---

## 2) Quickstart — Minimal Commands

Replace `TARGET` with a hostname or `host:port`.

### A) testssl.sh (most complete single-tool view)
```bash
./testssl.sh --fast --warnings off --openssl=default TARGET
# Full run (longer):
./testssl.sh --openssl=default --sneaky --parallel --idna TARGET
# JSON/CSV output:
./testssl.sh --jsonfile out/testssl-TARGET.json --csv out/testssl-TARGET.csv TARGET
```

### B) Nmap focused TLS scripts
```bash
nmap -p 443,8443,993,465 --script \
ssl-enum-ciphers,ssl-dh-params,ssl-heartbleed,ssl-ccs-injection,tls-alpn,tls-nextprotoneg \
-oN out/nmap-TARGET.txt -oX out/nmap-TARGET.xml TARGET
```

### C) SSLyze (good coverage + JSON)
```bash
sslyze --regular --json_out=out/sslyze-TARGET.json TARGET
```

### D) sslscan (quick cipher snapshot)
```bash
sslscan --no-failed --starttls-smtp TARGET:465   # example for SMTPS
sslscan --no-failed TARGET:443
```

### E) OpenSSL spot checks
```bash
# show leaf & chain
openssl s_client -connect TARGET:443 -servername TARGET -tls1_2 </dev/null | openssl x509 -noout -text
# restrict protocol versions to confirm they are rejected:
openssl s_client -connect TARGET:443 -servername TARGET -tls1 -quiet </dev/null
```

> Tip: Always test **by SNI** (`-servername TARGET`) to select the correct cert on multi-tenant servers.

---

## 3) Methodology (Step-by-Step)

1. **Port Discovery (optional)**  
   ```bash
   nmap -Pn -p 1-65535 --min-rate 500 TARGET
   ```
2. **Baseline TLS Inventory**  
   - testssl.sh **full** run per host/port.  
   - sslscan snapshot for quick human-readable cipher view.
3. **Protocol & Cipher Strength**  
   - Confirm **TLS 1.2/1.3** only; **reject** SSLv2/3, TLS1.0/1.1.  
   - Enumerate ciphers with `ssl-enum-ciphers` and testssl.sh; flag **RC4**, **3DES/DES**, **NULL/EXPORT**, **CBC (legacy)**.
4. **Forward Secrecy & Key Exchange**  
   - Ensure **ECDHE/X25519** is offered and preferred; no **RSA key exchange**.  
   - Validate **DH params ≥ 2048-bit** if DHE is used.
5. **Certificate & PKI**  
   - Check validity period, SANs, key usage/EKU, chain completeness, signature algorithm (**SHA-256+**), OCSP stapling.
6. **Known Vulnerabilities**  
   - Nmap NSE: `ssl-heartbleed`, `ssl-ccs-injection`; testssl.sh flags: **POODLE/BEAST/Lucky13/CRIME/BREACH/SWEET32/LOGJAM/FREAK/ROBOT** (where detectable).  
7. **Transport Features**  
   - ALPN negotiation (`h2`/`h3`), HSTS presence (via HTTP HEAD), TLS compression disabled, session ticket hygiene.
8. **Document Evidence**  
   - Save tool outputs (`out/`), capture key snippets in the **Findings** table below.
9. **Risk & Mitigation**  
   - Map each finding to **impact**, **root cause**, and **fix**; prioritize by exposure and likelihood.

---

## 4) Findings (Fill with Your Results)

> Use one row per host:port finding. Duplicate rows as needed.

| ID | Host:Port | Vulnerability / Weakness | Evidence (tool/output snippet) | Impact | Root Cause | Identification Method | Mitigation / Recommendation | Status |
|---|---|---|---|---|---|---|---|---|
| F-01 | example.com:443 | **TLS 1.0 enabled** | `testssl.sh: TLS 1.0 offered` | Susceptible to legacy CBC issues; weaker posture/compliance failures | Legacy compatibility left on | testssl.sh / openssl `-tls1` succeeded | Disable TLS 1.0/1.1; require 1.2/1.3 | Open |
| F-02 | api.example.com:443 | **RC4 ciphers offered** | `ssl-enum-ciphers: TLS_RSA_WITH_RC4_128_SHA` | Plaintext recovery from keystream biases | Weak stream cipher in server config | Nmap `ssl-enum-ciphers`, sslscan | Remove RC4; keep AEAD-only (AES-GCM/CHACHA20) | Open |
| F-03 | mail.example.com:993 | **No Forward Secrecy** | `ssl-enum-ciphers: RSA key exchange` | Past captures decryptable if key leaks | Using static RSA key exchange | Nmap `ssl-enum-ciphers` | Prefer ECDHE/X25519 suites; disable RSA key exchange | Open |
| F-04 | example.com:443 | **SWEET32 (3DES)** | `testssl.sh: 3DES present` | Birthday attack at high volumes | 64-bit block cipher allowed | testssl.sh / sslscan | Remove 3DES; prefer AES-GCM/ChaCha20 | Open |
| F-05 | api.example.com:443 | **Weak DH params (1024-bit)** | `ssl-dh-params: DH 1024 bits` | Logjam-style risk | Small DH group | Nmap `ssl-dh-params` | Use 2048-bit+ DH or ECDHE/X25519 | Open |
| F-06 | example.com:443 | **Heartbleed (if flagged)** | `ssl-heartbleed: VULNERABLE` | Key/material disclosure | OpenSSL heartbeat bug | Nmap `ssl-heartbleed` / testssl.sh | Patch OpenSSL; rotate keys, revoke old certs | Open |
| F-07 | example.com:443 | **POODLE (SSLv3)** | `openssl -ssl3 succeeded` | CBC padding oracle on SSLv3 | Legacy fallback allowed | OpenSSL probe | Disable SSLv3 + TLS_FALLBACK_SCSV | Open |
| F-08 | example.com:443 | **SHA-1 certificate** | `openssl x509 ... Signature Algorithm: sha1WithRSAEncryption` | Collision risk; non-compliant | Weak signature algorithm | OpenSSL/testssl.sh | Reissue with SHA-256+ | Open |
| F-09 | example.com:443 | **TLS compression enabled (CRIME)** | `testssl.sh: compression enabled` | Secret exfiltration via length | TLS-level compression on | testssl.sh | Disable TLS compression | Open |
| F-10 | www.example.com:443 | **BREACH risk** | Secrets in compressed responses | CSRF token leakage via length | HTTP response compression with secrets | Manual/HTTP check | Mask tokens, randomize, disable compression on secret pages | Open |

> Replace placeholders with actual evidence lines from your scans. Attach full outputs in `out/` directory.

---

## 5) Impact, Root Causes & Mitigations (Reference)

### A) Legacy Protocols (SSLv3, TLS1.0/1.1)
- **Impact:** Enables downgrade & CBC class attacks; fails compliance (PCI-DSS, etc.).  
- **Root cause:** Backwards compatibility kept enabled.  
- **Mitigation:** Enforce **TLS 1.2/1.3** only; enable **TLS_FALLBACK_SCSV**.

### B) Weak Ciphers (RC4, 3DES/DES, EXPORT/NULL)
- **Impact:** Plaintext recovery (RC4), SWEET32 risk (3DES), trivial break (EXPORT/NULL).  
- **Root cause:** Old defaults.  
- **Mitigation:** Allow **AEAD-only** suites: `AES-GCM`, `CHACHA20-POLY1305`.

### C) No Forward Secrecy (Static RSA key exchange)
- **Impact:** Recorded traffic becomes decryptable if private key leaks.  
- **Root cause:** Use of RSA key exchange.  
- **Mitigation:** Prefer **ECDHE/X25519**; disable static RSA key exchange.

### D) Weak DH Parameters
- **Impact:** Logjam-style compromise.  
- **Root cause:** 1024-bit or shared groups.  
- **Mitigation:** **2048-bit** (min) or **X25519**; strong groups.

### E) Certificate Issues (SHA-1/MD5, wrong SAN/EKU, long validity)
- **Impact:** Collisions; trust errors; MITM risks.  
- **Root cause:** Outdated CA practices/config.  
- **Mitigation:** Reissue with **SHA-256+**, correct SAN/EKU, short lifetimes; enable **OCSP stapling**.

### F) Known CVEs (Heartbleed, CCS Injection, ROBOT, etc.)
- **Impact:** Memory/key disclosure, MITM, decryption oracles.  
- **Root cause:** Vulnerable library/state machine; PKCS#1 v1.5 pitfalls.  
- **Mitigation:** Patch libraries; rotate keys; use **RSA-PSS** or ECDSA; uniform error handling.

### G) Compression Leaks (CRIME/BREACH)
- **Impact:** Secret leakage via length.  
- **Root cause:** TLS/HTTP compression with secrets in responses.  
- **Mitigation:** Disable TLS compression; for HTTP, avoid reflecting secrets, add padding/masking, rate-limit.

---

## 6) Identification Methods — Exact Commands & What to Look For

### Protocol Versions
```bash
# Expect failure for legacy:
openssl s_client -connect TARGET:443 -servername TARGET -ssl3 </dev/null
openssl s_client -connect TARGET:443 -servername TARGET -tls1 </dev/null
```
**Result to flag:** Any successful handshake with SSLv3/TLS1.0/1.1.

### Cipher Enumeration
```bash
nmap -p 443 --script ssl-enum-ciphers TARGET
sslscan --no-failed TARGET:443
```
**Result to flag:** RC4/3DES/DES/NULL/EXPORT, RSA key exchange (no PFS).

### DH Parameter Strength
```bash
nmap -p 443 --script ssl-dh-params TARGET
```
**Flag:** DH < **2048-bit**.

### Known CVEs
```bash
nmap -p 443 --script ssl-heartbleed,ssl-ccs-injection TARGET
./testssl.sh --fast TARGET
```
**Flag:** Any `VULNERABLE` status.

### Certificate & PKI
```bash
openssl s_client -connect TARGET:443 -servername TARGET </dev/null | openssl x509 -noout -text
```
**Flag:** `Signature Algorithm: sha1WithRSAEncryption`, invalid SAN, expired/not yet valid, missing EKU, OCSP failures.

### ALPN / HTTP
```bash
nmap -p 443 --script tls-alpn,tls-nextprotoneg TARGET
curl -I https://TARGET/        # check HSTS, server headers
```
**Flag:** No HSTS (policy choice), odd ALPN behavior if relevant.

---

## 7) Risk Rating & Prioritization

Use a simple scheme (Critical / High / Medium / Low) weighing **likelihood** and **impact**:
- **Critical**: Heartbleed, ROBOT (confirmed), SSLv3 enabled, static RSA only with leaks.  
- **High**: RC4/3DES enabled on public endpoints, TLS 1.0 enabled, weak DH.  
- **Medium**: Missing OCSP stapling, long-lived certs, no HSTS (contextual).  
- **Low**: Non-ideal header posture where business risks are minimal.

---

## 8) Remediation Plan (Template)

- **Phase 1 (7 days):** Disable SSLv3/TLS1.0/1.1; remove RC4/3DES/EXPORT; enable AEAD-only; prefer ECDHE/X25519.  
- **Phase 2 (14 days):** Reissue SHA-256+ certs; enforce OCSP stapling; rotate session tickets/keys.  
- **Phase 3 (30 days):** Validate DH params ≥2048 or switch to X25519; enable HSTS (pilot first); tighten ALPN.  
- **Continuous:** Patch crypto libraries; CI scan with `testssl.sh`/`sslyze`; monitor CT logs.

---

## 9) Automation Helpers

### Bash loop (testssl.sh + SSLyze)
```bash
#!/usr/bin/env bash
mkdir -p out
while read -r target; do
  [[ -z "$target" || "$target" =~ ^# ]] && continue
  ./testssl.sh --jsonfile out/testssl-"$target".json "$target"
  sslyze --regular --json_out=out/sslyze-"$target".json "$target"
done <<'EOF'
example.com:443
api.example.com:443
mail.example.com:993
EOF
```

### Nmap batch
```bash
nmap -iL targets.txt -p 443,8443,993,465 --script \
ssl-enum-ciphers,ssl-dh-params,ssl-heartbleed,ssl-ccs-injection,tls-alpn,tls-nextprotoneg \
-oA out/nmap-batch
```

---

## 10) Conclusion

This report provides a **complete, repeatable** process to identify SSL/TLS misconfigurations and vulnerabilities, map them to **impact** and **root causes**, and apply **concrete mitigations**. Fill the **Findings** table with your evidence and track remediation status to completion.

