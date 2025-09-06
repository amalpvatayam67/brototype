# Digital Signatures — Summary & Applications

**Author:** Amal P. • **Date:** 06 September 2025  
**Use:** Coursework report

---

## Summary

- A **digital signature** proves **who** signed (authenticity), that content **wasn’t altered** (integrity), and enables **non‑repudiation**.
- The signer uses a **private key** to sign a **hash** of the message; anyone can verify using the **public key**.
- Prefer modern schemes: **RSA‑PSS**, **ECDSA** (P‑256), or **Ed25519** (EdDSA). Use strong hashes (**SHA‑256+**).
- Trust hinges on **key distribution** and **verification** (PKI certificates, certificate transparency, or web‑of‑trust).

---

## 1) What Is a Digital Signature?

A digital signature is a cryptographic mechanism that binds a signer’s identity to a message. Only the private key holder can create a valid signature, while anyone with the public key can verify it.

**Security goals:**

- **Authenticity**: signature validates the signer’s identity.
- **Integrity**: any change in the signed content invalidates the signature.
- **Non‑repudiation**: signer cannot credibly deny having signed (given proper key custody and audit).

---

## 2) How It Works (High Level)

### Components

- **Key pair**: `(sk, pk)` = private key (kept secret) and public key (shared).
- **Hash function**: compresses arbitrary input to fixed‑length digest (e.g., SHA‑256).
- **Signature scheme**: algorithm to produce/verify signatures (RSA‑PSS, ECDSA, Ed25519).

### Signing

1. Compute `h = Hash(message)`
2. Compute `sig = Sign(sk, h)` (scheme‑specific; may be deterministic or use randomness)
3. Publish `(message, sig, pk or certificate)`

### Verification

1. Recompute `h' = Hash(message)`
2. Check `Verify(pk, h', sig) == true`
3. Optionally validate **certificate** (issuer CA, validity period, revocation via CRL/OCSP, CT logs).

### Algorithm intuition

- **RSA‑PSS**: operates on big integers modulo `n`; padding (PSS) makes signatures probabilistic and secure.
- **ECDSA**: uses elliptic curve math; requires **unique, unpredictable nonce `k` per signature** (reuse leaks `sk`). Deterministic ECDSA (RFC 6979) derives `k` from `(sk, h)`.
- **Ed25519**: modern EdDSA variant; **deterministic**, fast, resilient to many pitfalls, excellent default for signatures.

---

## 3) Trust & Key Distribution

- **PKI (Public Key Infrastructure)**: Public keys are embedded in **X.509 certificates** signed by a **Certificate Authority (CA)**. Browsers/OSs trust a set of root CAs.
- **Certificate Transparency**: public, append‑only logs for TLS certs; improves accountability for mis‑issued certificates.
- **Revocation**: **CRL** (Certificate Revocation List) or **OCSP** status checks.
- **Web of Trust (PGP/OpenPGP)**: decentralized model—users sign each other’s keys.
- **Key pinning / Key transparency**: bind identities to keys and audit changes over time.

---

## 4) Applications & Examples

1. **TLS/HTTPS**

   - Servers present CA‑signed certificates; clients verify the server’s identity. Handshakes often use **ECDSA** or **RSA** for authentication; session data is then protected with symmetric AEAD.

2. **Code Signing & Software Supply Chain**

   - OS packages, kernel modules, drivers, mobile apps, and updates are signed (e.g., Microsoft Authenticode, Apple Notarization, Android APK signing, Linux package managers).
   - Modern supply chain tooling signs **artifacts, SBOMs, and container images** (e.g., **Sigstore/cosign**). Prevents tampered releases.

3. **Document Signing**

   - **PDF, XML/Docx** digital signatures bind author identity and content (with timestamps). Supports legal/compliance workflows (e.g., e‑invoices, contracts).

4. **Email Authentication**

   - **S/MIME**: end‑to‑end mail signing and encryption using X.509 certs.
   - **DKIM**: domain‑level signatures applied by mail servers; with **DMARC**, helps prevent spoofing/phishing.

5. **Secure Boot & Firmware Integrity**

   - Bootloaders, BIOS/UEFI, and device firmware are verified with signatures, blocking unauthorized code on boot. Critical for IoT/embedded.

6. **Messaging Protocols**

   - End‑to‑end systems (Signal/Matrix/WhatsApp) sign keys/messages to authenticate participants and prevent MitM.

7. **Blockchain/Cryptocurrencies**

   - Transactions are authorized by signatures (e.g., **ECDSA** over secp256k1 or **Ed25519** variants). Ensures only key owners can spend funds.

8. **Timestamps & Notarization**
   - **Timestamp Authorities (TSA)** co‑sign to assert a signature existed at a specific time, aiding long‑term validity and legal standing.

---

## 5) Good Practices (Do This)

- Use modern schemes: **Ed25519** or **ECDSA P‑256** (signatures); **RSA‑PSS** (if RSA is required).
- Use **SHA‑256 or stronger**; avoid MD5/SHA‑1.
- Protect private keys in **HSMs/TPMs** or hardware tokens; enable **key rotation**.
- Include **context binding** in what you sign (e.g., domain separation tags, protocol version, purpose) to prevent cross‑protocol misuse.
- **Attach or reference** an immutable representation (canonicalization) to avoid signature‑wrapping/canonicalization attacks (notably in XML/JSON).
- Validate **certificates**: chain, hostname, validity, revocation; use **CT logs** for TLS.
- Add **trusted timestamps** for long‑term validation.
- Keep verification code **constant‑time** where relevant; rely on vetted libraries.

---

## 6) Common Pitfalls (Avoid This)

- **ECDSA nonce reuse** → private key recovery. Use deterministic ECDSA or high‑quality randomness.
- **Weak hashes** → collision attacks (e.g., MD5/SHA‑1) undermine trust.
- **Raw/legacy RSA** (PKCS#1 v1.5) without PSS → avoid for new designs.
- **Poor key custody** → if a private key is stolen, signatures lose value; enforce hardware protection and access controls.
- **Skipping revocation checks** → trusting compromised or expired certificates.
- **Signing the wrong thing** → always sign the **canonicalized payload** plus context (length, type, domain).

---

## 7) Minimal Pseudocode (Conceptual)

**Signing (Ed25519‑style):**

```
(sk, pk) = KeyGen()
h = Hash(message)
sig = Sign(sk, h)
publish message, sig, pk_or_cert
```

**Verification:**

```
h' = Hash(message)
ok = Verify(pk, h', sig)
if ok and certificate_is_valid(pk): accept else reject
```

---

## 8) Quick Reference

- **Algorithms**: RSA‑PSS, ECDSA (P‑256/P‑384), **Ed25519** (EdDSA).
- **Hashes**: SHA‑256/384/512, SHA‑3, BLAKE2/3 (where supported).
- **Artifacts**: TLS certs, signed packages/containers, PDF signatures, S/MIME/DKIM, firmware, blockchain tx.
- **Infrastructure**: PKI, CT logs, OCSP/CRL, HSM/TPM, timestamping authorities.

---

## 9) Conclusion

Digital signatures are the **identity and integrity layer** of modern security: they prove authorship, prevent tampering, and underpin trust—from HTTPS and software updates to secure boot and blockchains. Their power depends as much on **key management and trust infrastructure** as on the math itself—use modern algorithms, protect keys, and verify diligently.
