# Cryptography 101: Encryption vs. Encoding vs. Hashing

**Author:** Amal P. • **Date:** 06 September 2025  
**Use:** Coursework report 

---

## Summary

- **Encoding** = format conversion for **compatibility/transport**. *Reversible* without secrets (e.g., Base64, URL‑encoding).  
- **Encryption** = transforms data to protect **confidentiality**. *Reversible only with a secret key* (e.g., AES, RSA).  
- **Hashing** = one‑way fingerprint for **integrity** and **verification**. *Not reversible* (e.g., SHA‑256, BLAKE3).

> Choosing the right one:
> - Need to **store or send safely** so others can’t read? → **Encryption** (prefer AEAD like AES‑GCM/ChaCha20‑Poly1305).
> - Need to **verify data** hasn’t changed or store passwords securely? → **Hashing** (use salted **KDFs** like Argon2id/bcrypt/scrypt).
> - Need to **package data** cleanly for transport (email, URLs, JSON)? → **Encoding** (Base64, URL‑encode, UTF‑8).

---

## 1) What Is Cryptography—and Why It Matters

Cryptography is the study and practice of techniques that secure information and communications in the presence of adversaries. Its goals are often summarized as:

- **Confidentiality**: only authorized parties can read the data. *(Encryption)*
- **Integrity**: data can’t be altered undetected. *(Hashes, MACs)*
- **Authenticity**: verify who created/sent the data. *(Digital signatures, certificates)*
- **Non‑repudiation**: a sender cannot credibly deny a specific action. *(Digital signatures with auditability)*

### Core Principles

- **Kerckhoffs’s Principle**: systems should remain secure even if everything about the system is public **except the key**.
- **Key Management**: strong keys, secure storage (HSM/KMS), rotation, and access control are **more important** than the algorithm choice.
- **Modern Ciphers**: use vetted primitives (AES‑GCM, ChaCha20‑Poly1305, X25519, Ed25519, SHA‑256/512, BLAKE3).
- **Do Not Roll Your Own Crypto**: use well‑maintained, audited libraries.
- **Entropy & Randomness**: use CSPRNGs for keys, nonces, salts.
- **Fail‑safe Defaults**: prefer **AEAD** modes (Authenticated Encryption with Associated Data) to get confidentiality **and** integrity.

---

## 2) Definitions and Differences

### Encoding
- **Purpose**: convert data to a safe/compatible representation for storage or transmission.  
- **Reversibility**: **Reversible** *without* a key.  
- **Examples**: Base64 (binary → text), URL‑encoding (`%20` for space), UTF‑8 (text character encoding), QR codes.  
- **Security**: **No security**—it’s not secret; anyone can decode.

### Encryption
- **Purpose**: protect **confidentiality** so only holders of the key can read the data.  
- **Reversibility**: **Reversible** *with* the correct key.  
- **Types**:  
  - **Symmetric** (same key): AES‑GCM, ChaCha20‑Poly1305.  
  - **Asymmetric** (public/private keys): RSA, EC (X25519, P‑256).  
- **Integrity**: use **AEAD** (e.g., AES‑GCM) or pair encryption with a **MAC**/signature to prevent tampering.

### Hashing
- **Purpose**: produce a fixed‑size **fingerprint** of data for integrity check, indexing, deduplication, or password storage (via KDFs).  
- **Reversibility**: **One‑way** (practically irreversible).  
- **Security properties**:  
  - **Preimage resistance** (hard to find input for a given hash)  
  - **Second‑preimage resistance** (hard to find a different input with same hash)  
  - **Collision resistance** (hard to find two different inputs with same hash)  
- **Password storage**: use a slow, **memory‑hard KDF** (Argon2id preferred; bcrypt/scrypt acceptable) with **unique salts** and adequate parameters.

### Quick Comparison

| Aspect | Encoding | Encryption | Hashing |
|---|---|---|---|
| Primary goal | Compatibility / transport | Confidentiality (often integrity with AEAD) | Integrity / verification |
| Reversible? | Yes (no secret) | Yes (with key) | No (one‑way) |
| Secret/key needed? | No | Yes | No |
| Output size | Grows predictably (e.g., Base64 +33%) | Similar to input (+ metadata/IV) | Fixed size (e.g., 256 bits) |
| Typical tools | Base64, URL‑encode, UTF‑8 | AES‑GCM, ChaCha20‑Poly1305, RSA | SHA‑256/512, BLAKE3; KDFs: Argon2id/bcrypt |
| Common mistake | Thinking it adds security | Using ECB or no integrity | Using fast hash for passwords |

---

## 3) Why Each Is Used (with Real‑World Cases)

### Encoding — *Make data portable/compatible*
- **Email attachments**: MIME Base64 encodes binaries so they travel safely over text‑only systems.
- **URLs & Web**: percent‑encoding to represent spaces/Unicode in links and query strings.
- **APIs & JSON**: binary blobs (images, keys) encoded as Base64 strings.
- **Text encodings**: UTF‑8 enables consistent, global text representation.

### Encryption — *Keep secrets secret*
- **HTTPS/TLS**: protects web traffic from eavesdropping and tampering.
- **Full‑disk / file encryption**: BitLocker, FileVault, LUKS protect lost/stolen devices.
- **End‑to‑end messaging**: Signal/WhatsApp/Matrix use modern AEAD + forward secrecy.
- **Backups & cloud storage**: client‑side encryption ensures only you can decrypt.
- **VPNs / Zero‑Trust**: encrypts network tunnels between clients and services.
- **Database encryption**: encrypt columns (e.g., PII) or entire datasets at rest.

### Hashing — *Verify, index, and prove*
- **Password storage**: store **KDF digests** (Argon2id/bcrypt) with **unique salt**; never store plain or reversible secrets.
- **Integrity checks**: compare file hash before/after transfer (e.g., SHA‑256 checksums).
- **Digital signatures**: sign the hash of a message (RSA/ECDSA/Ed25519) for authenticity & non‑repudiation.
- **Deduplication**: content‑addressed storage (e.g., Git, IPFS) uses hashes as IDs.
- **Blockchain & Merkle trees**: link blocks and verify large datasets efficiently.

---

## 4) When to Use Which (Decision Guide)

- **Transporting binary data over text channels?** → **Encoding** (Base64).  
- **Protecting private data in storage or transit?** → **Encryption** (use **AEAD**).  
- **Verifying integrity or storing passwords securely?** → **Hashing** (KDFs for passwords).  
- **Verifying the sender and preventing denial?** → **Digital signatures** (hash + private key).  
- **Mixing needs?** Often you **combine** primitives:
  - **Hybrid encryption**: use recipient’s **public key** to encrypt a one‑time symmetric key; use that key to encrypt the data (fast).  
  - **Encrypt‑then‑MAC** or **AEAD**: ensure both confidentiality **and** integrity.  
  - **Passwords**: never encrypt; instead **hash with KDF + salt (+ pepper in app config/KMS)**.

---

## 5) Practical Examples

### A) Password Handling (Best Practice)
1. **User creates password** → generate a **random salt**.  
2. Compute **Argon2id(password, salt, parameters)** → store `(salt, params, digest)` in DB.  
3. On login, recompute with stored salt/params and compare digests (constant‑time compare).  
4. Optionally add a **server‑side pepper** stored in a secure KMS (not in the DB).

> ❌ Don’t: store plaintext passwords; use fast hashes (MD5/SHA‑1/SHA‑256) for passwords; reuse salts; hard‑code secrets.

### B) Secure Message
- Use **X25519** to agree on a shared key; encrypt message with **ChaCha20‑Poly1305**; include a nonce; verify tag before decryption.

### C) File Transfer Check
- Sender publishes file + **SHA‑256 checksum**. Receiver hashes downloaded file and compares. If equal → integrity confirmed.

---

## 6) Common Pitfalls & How to Avoid Them

- **Confusing Base64 with encryption** → Encoding ≠ security. Anyone can decode.
- **ECB mode** (AES‑ECB) → leaks patterns. Use **AEAD** (AES‑GCM/ChaCha20‑Poly1305).
- **No integrity** → raw encryption without MAC/signature allows undetected tampering.
- **Nonce/IV reuse** → catastrophic in GCM/CTR. Always use unique nonces (from CSPRNG or counters as designed).
- **Weak/outdated algorithms** → avoid MD5, SHA‑1, DES, 3DES, RC4, small RSA keys.
- **Rolling your own crypto** → use proven libraries (libsodium, NaCl, BoringSSL, OpenSSL with safe defaults).
- **Poor key management** → keys in code/repos; no rotation; no HSM/KMS.
- **Hashing passwords with fast hash** → use **Argon2id/bcrypt/scrypt** with strong parameters.
- **Storing salts improperly** → salts can be public, but **must be unique per password**.
- **JWT “none” or weak signing** → ensure robust algorithms (RS256/EdDSA) and key hygiene.

---

## 7) Cheat‑Sheet Summary

| Use‑case | You need | Recommended |
|---|---|---|
| Send binary through text channel | Encoding | Base64 |
| Hide content from others | Encryption | AES‑GCM / ChaCha20‑Poly1305 |
| Verify file integrity | Hashing | SHA‑256/512, BLAKE3 |
| Store user passwords | Hashing (KDF) | Argon2id (or bcrypt/scrypt) + unique salt (+ pepper) |
| Authenticate sender & non‑repudiation | Signatures | Ed25519 / ECDSA / RSA‑PSS |
| Large data with both confidentiality & integrity | AEAD | AES‑GCM / ChaCha20‑Poly1305 |
| Multiple recipients | Hybrid crypto | One symmetric key encrypted per recipient’s public key |

---

## 8) Glossary (Quick Definitions)

- **AEAD**: Authenticated Encryption with Associated Data—single operation for confidentiality + integrity.  
- **MAC**: Message Authentication Code—integrity/authenticity using a shared secret (e.g., HMAC‑SHA‑256).  
- **KDF**: Key Derivation Function—derives strong keys or stores passwords with work factor (Argon2id/bcrypt).  
- **Salt**: random per‑password value preventing rainbow table attacks.  
- **Pepper**: extra secret (app‑level) combined before KDF; stored separately (e.g., KMS).  
- **CSPRNG**: cryptographically secure random number generator.  
- **PKI**: Public Key Infrastructure—certificates, CAs, and trust chains for identities.

---

## 9) Further Reading (Neutral, Non‑linked)
- NIST SP 800‑57 (Key Management) & SP 800‑63 (Digital Identity).  
- RFC 5116 (AEAD), RFC 8439 (ChaCha20‑Poly1305), FIPS 197 (AES).  
- libsodium documentation; OWASP Cryptographic Storage Cheat Sheet.  
- “Serious Cryptography” by Jean‑Philippe Aumasson.

---

## 10) Conclusion

- **Encoding** solves format/transport problems—not security.  
- **Encryption** protects confidentiality (and with AEAD, integrity).  
- **Hashing** provides tamper‑evidence and identity anchors; for passwords, always use a **KDF**.  

Use vetted algorithms, manage keys well, and combine primitives correctly for layered security.
