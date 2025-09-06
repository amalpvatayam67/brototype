# Symmetric vs Asymmetric Encryption — With Examples (AES, DES, RSA, ECC)

**Author:** Amal P. • **Date:** 06 September 2025  
**Use:** Coursework report

---

## Summary

- **Symmetric encryption**: one secret key for **encrypt** and **decrypt** (fast; great for bulk data).  
  - Examples: **AES** (modern standard), **DES** (legacy/insecure; shown for history).  
- **Asymmetric encryption**: **public key** to encrypt/verify, **private key** to decrypt/sign (enables key exchange, signatures).  
  - Examples: **RSA**, **ECC** (e.g., X25519 for key exchange, Ed25519/ECDSA for signatures).  
- In practice, systems use **hybrid encryption**: asymmetric to set up a shared secret, **symmetric (AEAD)** to encrypt the data.

---

## 1) Symmetric vs Asymmetric — The Big Picture

| Property | Symmetric (e.g., AES) | Asymmetric (e.g., RSA/ECC) |
|---|---|---|
| Keys | **One key** shared by parties | **Key pair**: public + private |
| Speed | **Fast**, constant-time possible, great for large data | **Slower**, used for small data (keys, signatures) |
| Typical sizes | 128–256-bit keys | RSA **2048–4096** bits; ECC **256–521** bit curves |
| Use cases | Disk/files, VPNs, TLS record layer, backups | TLS handshakes, digital signatures, key exchange |
| Challenges | Secure key distribution & rotation | Correct padding/nonce handling; side-channel hardening |
| Integrity | Use **AEAD** (AES-GCM/ChaCha20-Poly1305) or MAC | Signatures (RSA-PSS/ECDSA/EdDSA) or KEM+AEAD |

> **Rule of thumb**: use **AEAD** ciphers (AES‑GCM or ChaCha20‑Poly1305) for data; use **asymmetric** (RSA or ECC) to agree on keys and authenticate.

---

## 2) Symmetric Encryption Examples

### A) AES — Advanced Encryption Standard (Recommended)
- **Design**: Substitution–Permutation Network (S‑boxes + linear mixing).  
- **Block size**: 128 bits; **Key sizes**: 128/192/256 bits.  
- **Modes**:  
  - **GCM** (Galois/Counter Mode) → **AEAD** (confidentiality + integrity).  
  - **CTR/CFB/OFB** (legacy/stream-like); **CBC** (legacy; needs padding & external MAC).  
- **Why it’s used**: Ubiquitous hardware support (AES‑NI, ARMv8), excellent performance and security when used with **unique nonces** and authenticated modes.
- **Typical uses**: TLS 1.2/1.3 record encryption (AES‑GCM), disk/file encryption (AES‑XTS for storage), database/backup encryption.

**Mini intuition (CTR-like):**
```
keystream_block = AES_encrypt(key, nonce || counter)
cipher_block = plaintext_block XOR keystream_block
```
> **Pitfalls**: Never reuse a **(key, nonce)** pair in CTR/GCM; avoid ECB; ensure constant-time implementations.

---

### B) DES — Data Encryption Standard (Legacy/Insecure)
- **Design**: 16‑round **Feistel network**.  
- **Block size**: 64 bits; **Effective key**: **56 bits**.  
- **Status**: Considered **insecure** due to feasible brute‑force; **3DES** (triple DES) extended life but is **legacy only** today.  
- **Why we still study it**: foundational for understanding Feistel structures and the evolution toward AES.

**Takeaway**: Do **not** use DES/3DES for new systems. Prefer **AES‑GCM** or **ChaCha20‑Poly1305**.

---

## 3) Asymmetric Encryption Examples

### A) RSA — Rivest–Shamir–Adleman
- **Idea**: Security relies on difficulty of **factoring large integers** (product of two big primes).  
- **Keys**: public `(n, e)` and private `d`. Common sizes: **2048** or **3072** bits.  
- **Operations**:  
  - **Encryption**: `c = m^e mod n` (with padding).  
  - **Decryption**: `m = c^d mod n`.  
  - **Signatures**: sign a **hash** (use **RSA‑PSS**) and verify with public key.  
- **Padding/Schemes**:  
  - **RSA‑OAEP** for encryption (probabilistic, secure against many attacks).  
  - **RSA‑PSS** for signatures (modern, robust).  
- **Uses**: TLS certificates, package signing (sometimes), legacy hybrid key transport.

> **Pitfalls**: Never use “raw RSA” without OAEP/PSS; beware timing side‑channels; validate key sizes and parameters.

---

### B) ECC — Elliptic Curve Cryptography
- **Idea**: Security relies on hardness of the **Elliptic Curve Discrete Logarithm Problem**.  
- **Why ECC**: Much **smaller keys** for comparable security (e.g., **P‑256** or **Curve25519** ≈ RSA‑3072). Efficient on constrained devices.  
- **Examples**:  
  - **ECDH/X25519** for **key exchange** (derive a shared secret).  
  - **ECDSA/Ed25519** for **digital signatures** (sign hash; verify with public key).  
- **Curves**: NIST P‑256/P‑384, **Curve25519** (X25519 for ECDH), **Ed25519** (EdDSA).  
- **Uses**: TLS 1.3 handshakes (ECDHE), Signal/WhatsApp, SSH keys, secure boot.

> **Pitfalls**: **Nonce reuse** in ECDSA leaks the private key; use reliable libraries; choose safe curves; constant‑time math is essential.

---

## 4) How They Work Together — Hybrid Encryption

Most real systems combine both worlds:

1. **Key Agreement / Transport** (asymmetric):  
   - **ECDHE/X25519** or **RSA‑OAEP** establishes a fresh session key.
2. **Bulk Data Protection** (symmetric):  
   - Use **AEAD** (AES‑GCM or ChaCha20‑Poly1305) to encrypt and authenticate the actual payload.

Benefits: **confidentiality + integrity + forward secrecy** (with ephemeral ECDH).

---

## 5) Quick Selection Guide

- Need to encrypt **large files/streams** efficiently? → **AES‑GCM** (or ChaCha20‑Poly1305).  
- Need to **establish keys** or **sign**? → **ECC** (X25519, Ed25519) or **RSA** with modern padding.  
- Targeting **constrained/mobile** devices? → Prefer **ECC** for handshakes, **ChaCha20‑Poly1305** for data on CPUs without AES acceleration.  
- **Never** choose DES/3DES for new designs.

---

## 6) Minimal Pseudocode Sketches

**RSA‑OAEP Encryption (very high level):**
```
c = RSA_OAEP_Encrypt(pubkey, plaintext)
p = RSA_OAEP_Decrypt(privkey, c)
```

**ECDH (X25519) + AEAD:**
```
shared = X25519(local_priv, peer_pub)
k = KDF(shared, context)
nonce = unique()
ciphertext, tag = AEAD_Encrypt(k, nonce, plaintext, aad)
```

**AES‑GCM (conceptual):**
```
nonce = unique()
ciphertext, tag = AES_GCM_Encrypt(key, nonce, plaintext, aad)
```

---

## 7) Best Practices & Pitfalls

- Prefer **AEAD** (AES‑GCM / ChaCha20‑Poly1305) for confidentiality **and** integrity.  
- Generate **unique nonces** per key; never reuse IVs in CTR/GCM.  
- Use **RSA‑OAEP** for encryption and **RSA‑PSS** for signatures; avoid PKCS#1 v1.5 where possible.  
- For ECC signatures, use **Ed25519** or correctly implemented **ECDSA** with robust randomness.  
- Manage keys with **KMS/HSM**, rotate regularly, and protect against side‑channels.  
- **Do not roll your own crypto**; use vetted libraries (libsodium/NaCl, BoringSSL, OpenSSL) and safe defaults.

---

## 8) Conclusion

- **Symmetric** (AES) is your fast workhorse for data-at-rest/in-transit; **DES** is historical and insecure today.  
- **Asymmetric** (RSA, ECC) enables secure key exchange and signatures with practical key sizes and trust models.  
- Real systems are **hybrid**: asymmetric for setup/authentication, symmetric AEAD for the heavy lifting.

