# SSL/TLS Vulnerabilities — Field Report (Weak Ciphers, PFS, Signatures, POODLE & More)

**Author:** Amal P. • **Date:** 06 September 2025  
**Use:** Coursework report

---

## Summary

- **Disable legacy**: SSLv2/SSLv3, TLS 1.0/1.1, **RC4**, **3DES/DES**, **EXPORT**, **NULL**, **aNULL**, **MD5/SHA-1 signatures**.
- **Require Forward Secrecy**: use **ECDHE** (or X25519) key exchange; avoid RSA key exchange.
- **Prefer modern AEAD**: **TLS 1.3** ciphers (AES-GCM, ChaCha20-Poly1305). For TLS 1.2, use **ECDHE + AES-GCM/CHACHA20** only.
- **Kill downgrades & compression**: enable **TLS_FALLBACK_SCSV**, disable **TLS compression** and mitigate **BREACH** on HTTP.
- **Patch libraries & validate certs**: keep OpenSSL/BoringSSL/etc. updated; enforce proper **hostname** and **EKU** checks, OCSP stapling/CRL.

---

## 1) Concepts You Must Know

### Weak cipher suites

- **RC4**: statistical biases → plaintext recovery.
- **3DES/DES**: 64-bit block size → **SWEET32** birthday attack at high traffic volumes; DES key length (56-bit) brute-forceable.
- **EXPORT/NULL/aNULL**: intentionally weak or without authentication; trivial to break.
- **CBC modes** (TLS ≤1.2): vulnerable to padding/oracle/timing attacks if not carefully implemented.

### Forward Secrecy (PFS)

- Sessions using **ECDHE/DHE** generate **ephemeral** keys; compromise of the server’s long-term key **does not** expose past traffic.
- **RSA key exchange** (non-ephemeral) **lacks PFS**: if the server private key is later stolen, captured sessions can be decrypted.

### Weak signature algorithms

- **MD5** and **SHA-1** are **broken** (collisions). Certificates or handshake signatures using these are unsafe.
- Prefer **SHA-256+**, **RSA-PSS**, **ECDSA (P‑256/P‑384)**, **Ed25519**.
- **ECDSA nonce reuse** leaks private keys—use deterministic ECDSA (RFC 6979) or high-quality randomness.

---

## 2) Named Vulnerabilities (What, Root Cause, Fix)

### Downgrade & Legacy Fallback

- **POODLE (SSLv3)** – _Padding Oracle On Downgraded Legacy Encryption_
  - **Cause**: SSLv3 CBC padding not integrity-protected; attacker forces **downgrade** to SSLv3.
  - **Impact**: Byte-at-a-time cookie recovery.
  - **Fix**: **Disable SSLv3** everywhere; deploy **TLS_FALLBACK_SCSV**; prefer AEAD suites.
- **POODLE-TLS / GOLDENDOODLE / Zombie POODLE**
  - **Cause**: TLS CBC padding/oracle side channels in specific implementations.
  - **Fix**: Patch libraries; prefer **AES-GCM/ChaCha20-Poly1305**.
- **FREAK** (Factoring RSA-EXPORT Keys)
  - **Cause**: Acceptance of **EXPORT**-grade RSA; attacker downgrades ciphers.
  - **Fix**: Remove EXPORT ciphers; update clients/servers.
- **Logjam**
  - **Cause**: **EXPORT**-grade **DHE** (512-bit) and reuse of common DH groups.
  - **Fix**: Disable export DHE; require **2048-bit+** DH or **X25519**; unique/standard strong groups.
- **SLOTH**
  - **Cause**: Use of **MD5/SHA-1** in handshake signatures enables protocol downgrades.
  - **Fix**: Forbid weak SigAlgs; require SHA-256+.
- **DROWN**
  - **Cause**: Shared cert/key on a server that still supports **SSLv2** allows cross-protocol decryption.
  - **Fix**: Disable SSLv2 everywhere; isolate keys; retire legacy services.

### CBC / Padding / Timing

- **BEAST** (TLS 1.0)
  - **Cause**: Predictable IVs in TLS 1.0 **CBC**; chosen-plaintext via browsers.
  - **Fix**: Use TLS 1.1+ or AEAD; (historical 1/n-1 split mitigations).
- **Lucky 13**
  - **Cause**: Timing side-channels in MAC-then-Encrypt **CBC** processing.
  - **Fix**: Constant-time decrypt; prefer AEAD ciphers.
- **SWEET32**
  - **Cause**: **64-bit block** ciphers (3DES) suffer birthday attacks with large traffic.
  - **Fix**: Disable **3DES/DES**; use AES-GCM/ChaCha20.

### RSA / DH / Key-Exchange Oracles & Side-Channels

- **Bleichenbacher/ROBOT**
  - **Cause**: **PKCS#1 v1.5** RSA decryption oracle via subtle error behaviors.
  - **Fix**: Use **RSA-OAEP** (for encryption), constant-time checks, uniform errors; or prefer ECDHE + signatures.
- **Raccoon**
  - **Cause**: Timing side-channel on **DHE** secret reuse with specific configurations.
  - **Fix**: Avoid DH secret reuse; prefer **X25519/ECDHE**; patch stacks.
- **Weak DH groups**
  - **Cause**: 1024-bit or shared groups can be precomputed by adversaries.
  - **Fix**: **2048-bit** (min) or **X25519**; unique strong params.

### Compression & Length-Leak

- **CRIME** (TLS compression)
  - **Cause**: TLS-level compression leaks secrets via compressed length.
  - **Fix**: Disable TLS compression.
- **BREACH** (HTTP compression)
  - **Cause**: Response compression leaks CSRF tokens/cookies via length side-channel.
  - **Fix**: Randomize secrets, mask CSRF tokens, disable compression on secret-bearing pages, add rate limits and padding.

### Library & Implementation Bugs

- **Heartbleed** (OpenSSL)
  - **Cause**: Bounds-checking flaw in heartbeat extension → memory disclosure (keys/secrets).
  - **Fix**: Patch OpenSSL; rotate keys/certs; revoke old certs.
- **OpenSSL CCS Injection**, **Renegotiation (2009)**, **Triple Handshake**
  - **Cause**: Handshake state machine flaws enabling MiTM or key synchronization issues.
  - **Fix**: Patch; disable/limit renegotiation; use extended master secret (EMS).
- **TicketBleed** (F5), **goto fail** (Apple), misc. validation bugs
  - **Cause**: Vendor-specific parser/logic mistakes, missing hostname checks.
  - **Fix**: Update firmware/OS; add integration tests; enforce strict validation.

### Stream Biases & Misc

- **RC4 biases / Bar Mitzvah**
  - **Cause**: Non-uniform keystream in **RC4** enables plaintext recovery.
  - **Fix**: Disable RC4 entirely.
- **ALPACA** (Application Layer Protocol Confusion)
  - **Cause**: Same certs across different protocols (HTTPS/IMAPS/FTPS); cross-protocol confusion.
  - **Fix**: Separate certs/ports; strict ALPN; app-layer hardening.
- **TLS 1.3 0‑RTT replay** (not a “bug” but a risk)
  - **Cause**: Early data can be replayed by adversaries.
  - **Fix**: Accept **idempotent** requests only; use anti-replay windows or disable 0‑RTT.

---

## 3) Root Causes — A Taxonomy

1. **Legacy protocol design**: SSLv2/3, TLS 1.0 CBC quirkiness (BEAST/POODLE).
2. **Weak primitives**: RC4 biases, 64‑bit block ciphers (3DES/DES), MD5/SHA‑1 collisions.
3. **Downgrade paths**: fallback dance, accepting EXPORT suites, lack of **TLS_FALLBACK_SCSV**.
4. **Side-channels/oracles**: timing (Lucky13, Raccoon), padding oracles (POODLE), error message oracles (Bleichenbacher/ROBOT).
5. **Compression leakage**: TLS/HTTP compression length side-channels (CRIME/BREACH).
6. **Implementation bugs**: parsing, state machine, memory safety (Heartbleed, CCS, TicketBleed, goto fail).
7. **Weak key management**: RSA key exchange (no PFS), weak DH groups, ECDSA nonce reuse, certificate validation mistakes.
8. **Ecosystem/PKI weaknesses**: mis-issued certs, poor revocation (CRL/OCSP), long-lived keys.

---

## 4) Detection — How to Find These in the Wild

- **Automated scanners**: `testssl.sh`, `sslscan`, **sslyze**, **nmap** `--script ssl-enum-ciphers`, Qualys SSL Labs.
- **OpenSSL client**:
  - List server ciphers: `openssl s_client -connect host:443 -tls1_2 -cipher 'ALL'`
  - Force legacy: `-ssl3`, `-tls1`, `-tls1_1` (to confirm they’re **rejected**).
- **Wireshark**: verify **ALPN**, version, cipher, compression, extensions; confirm **no TLS compression** and no SSLv3/TLS1.0.
- **Config review**: ensure HSTS, OCSP stapling, correct SNI/hostname validation and EKU.

---

## 5) Mitigation & Hardening Checklist

- **Protocol**: Disable **SSLv2/SSLv3/TLS1.0/TLS1.1**; enable **TLS 1.2+**, prefer **TLS 1.3**.
- **Ciphers**: Only **AEAD** (AES‑GCM/ChaCha20‑Poly1305). Disable **RC4**, **3DES/DES**, **CBC** where possible.
- **Key exchange**: **ECDHE/X25519** only; no RSA key exchange; DH ≥ **2048-bit** if used.
- **Signatures**: **SHA‑256+**, **RSA‑PSS**, **ECDSA/Ed25519**; forbid **MD5/SHA‑1**.
- **Certificates**: 2048‑bit RSA minimum or P‑256/Ed25519; enable **OCSP stapling**; short lifetimes and automation (ACME).
- **Downgrade protection**: **TLS_FALLBACK_SCSV**, disable EXPORT, set **server cipher preference**.
- **Compression**: Disable **TLS compression**; mitigate **BREACH** (no secrets in compressed responses, randomize/mask tokens).
- **Renegotiation**: Disable or tightly control; ensure **secure renegotiation** support/EMS.
- **Libraries**: Keep OpenSSL/BoringSSL/mbedTLS/etc. updated; enable constant-time primitives; test with CI.
- **Operational**: Key rotation, HSM/KMS storage, monitor CT logs, use CSP/referrer policy to reduce secret reflection.

---

## 6) Quick Reference — Safe Cipher Sets

- **TLS 1.3** (recommended):
  - `TLS_AES_128_GCM_SHA256`
  - `TLS_AES_256_GCM_SHA384`
  - `TLS_CHACHA20_POLY1305_SHA256`
- **TLS 1.2 (only if needed)**:
  - `ECDHE-ECDSA-AES128-GCM-SHA256`
  - `ECDHE-RSA-AES128-GCM-SHA256`
  - `ECDHE-ECDSA-CHACHA20-POLY1305`
  - `ECDHE-RSA-CHACHA20-POLY1305`

> Ensure **server preference** is honored, and **session tickets** are rotated to prevent long-term key reuse.

---

## 7) Appendix — Vulnerability Map (Table)

| Vulnerability  | Category         | Root Cause                   | Quick Test                     | Mitigation                                   |
| -------------- | ---------------- | ---------------------------- | ------------------------------ | -------------------------------------------- |
| POODLE (SSLv3) | Downgrade/CBC    | SSLv3 padding oracle         | Refuse `-ssl3`; check SSL Labs | Disable SSLv3; TLS_FALLBACK_SCSV             |
| BEAST          | CBC (TLS 1.0)    | Predictable IVs              | Force TLS1.0; analyze CBC      | Use TLS1.1+/AEAD                             |
| Lucky 13       | Timing/CBC       | MAC-then-Encrypt timing      | Library version audit          | Patch; use AEAD                              |
| FREAK          | Downgrade        | EXPORT RSA                   | Cipher list shows EXPORT       | Remove EXPORT ciphers                        |
| Logjam         | Downgrade/DH     | Weak DHE/export groups       | Check DH params size           | DHE≥2048 or X25519                           |
| DROWN          | Cross-protocol   | SSLv2 enabled elsewhere      | Scan for SSLv2                 | Disable SSLv2; key isolation                 |
| SWEET32        | Block size       | 64‑bit blocks (3DES)         | See 3DES enabled               | Disable 3DES                                 |
| RC4 biases     | Stream bias      | RC4 enabled                  | See RC4 in list                | Disable RC4                                  |
| CRIME          | Compression      | TLS compression on           | Check compression ext          | Disable TLS compression                      |
| BREACH         | Compression      | HTTP compression length leak | Secret in compressed pages     | Mask tokens; disable compression selectively |
| ROBOT          | Padding oracle   | RSA PKCS#1 v1.5 errors       | ROBOT scanner                  | Uniform errors; use PFS                      |
| Heartbleed     | Impl bug         | Bounds-check fail            | Version/CVE check              | Patch & rotate keys                          |
| Renegotiation  | Protocol flaw    | Insecure renegotiation       | SSL Labs flag                  | Patch; disable renegotiation                 |
| ALPACA         | Cross-protocol   | Same cert across protocols   | Mixed services/certs           | Separate certs/ALPN hardening                |
| Raccoon        | Timing/DH        | DH secret reuse timing       | Version/config audit           | Patch; prefer X25519                         |
| 0‑RTT replay   | Design trade-off | Early data replay            | Server allowing 0‑RTT          | Allow idempotent only / disable 0‑RTT        |

---

## 8) Conclusion

Most SSL/TLS failures come from **legacy baggage**, **weak primitives**, **downgrade pathways**, and **implementation mistakes**. The fastest path to safety is: **TLS 1.3 everywhere**, **AEAD-only ciphers**, **ECDHE/X25519** for key exchange, **SHA‑256+ signatures**, **no compression**, aggressive **patching**, and continuous **scanning**. Tie it all together with solid key management, short-lived certs, and vigilant monitoring.
