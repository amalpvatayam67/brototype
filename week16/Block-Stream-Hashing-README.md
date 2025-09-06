# Block Ciphers, Stream Ciphers & Hashing — A Practical Report

**Author:** Amal P. • **Date:** 06 September 2025  
**Use:** Coursework report

---

## Summary

- **Block cipher**: keyed permutation on **fixed-size blocks** (e.g., AES-128 on 128-bit blocks). Use **modes** (GCM/CTR/CBC) to handle long messages. Prefer **AEAD** modes like **AES-GCM** for confidentiality **+** integrity.
- **Stream cipher**: generates a **keystream**; ciphertext = plaintext **XOR** keystream. Never **reuse nonces/IVs** (two‑time pad disaster). Prefer **ChaCha20‑Poly1305** for speed & robustness.
- **Hash function**: **one‑way** fixed‑length fingerprint (integrity, dedup, signatures, password storage via **KDFs** like Argon2id). Avoid MD5/SHA‑1.

---

## 1) Where They Fit in the Security Puzzle

- **Confidentiality** → **Encryption** (block or stream ciphers).
- **Integrity / Authenticity** → **MACs/Signatures** (keyed hash or public‑key over a hash).
- **Tamper‑evidence / Fingerprints / Password storage** → **Hashing** (with KDFs for passwords).

> Rule of thumb: use **AEAD** (e.g., AES‑GCM or ChaCha20‑Poly1305) whenever possible so you get encryption **and** integrity in one go.

---

## 2) Block Ciphers

### What they are

A **block cipher** is a deterministic, keyed permutation on **n‑bit blocks**. With the key fixed, each block maps to another block of the same size in a **reversible** way.

- **Design families**:

  - **SPN (Substitution‑Permutation Network)**: e.g., **AES** (S‑boxes + linear mixing).
  - **Feistel networks**: e.g., **DES**, **3DES**, **Camellia** (split, round functions, swap).

- **Typical parameters**:
  - **Block size**: often **128 bits** (AES).
  - **Key size**: AES‑128/192/256 (security grows with key length).

### Why modes of operation are needed

Block ciphers operate on single blocks. **Modes** chain blocks to encrypt arbitrary‑length messages and (ideally) provide integrity.

- **ECB** (Electronic Codebook) — ❌ **Do not use**: identical plaintext blocks → identical ciphertext blocks (leaks patterns).
- **CBC** (Cipher Block Chaining): needs unpredictable **IV**; requires **padding**; not parallelizable on encrypt; integrity not guaranteed.
- **CTR** (Counter): turns a block cipher into a **stream**; parallelizable; needs **unique nonce/counter**; no integrity by itself.
- **XTS**: disk encryption (tweak per sector).
- **AEAD modes** (recommended):
  - **GCM** (Galois/Counter Mode): CTR for confidentiality + GHASH for integrity. **Requires unique nonce per key**.
  - **CCM/EAX/OCB**: alternative AEADs (OCB historically patent‑encumbered).

### Padding (for block modes like CBC)

- **PKCS#7**: append `k` bytes of value `k` to fill the last block. AEAD modes like **GCM** (stream‑like) avoid padding.

### Security & performance notes

- **Nonce/IV**: must be random (CBC) or unique (CTR/GCM). **Reuse in GCM/CTR is catastrophic**.
- **Parallelism**: **CTR/GCM** parallelize well; **CBC** encryption does not.
- **Side‑channels**: constant‑time implementations; avoid key‑dependent branches/table lookups.
- **Hardware accel**: AES‑NI/ARMv8 Crypto Extensions drastically improve AES performance.

---

## 3) Stream Ciphers

### What they are

A **stream cipher** produces a pseudorandom **keystream** from a secret key (and nonce). Encryption is simply:

```
C = P XOR Keystream
P = C XOR Keystream
```

- **Synchronous** stream ciphers: keystream depends only on key+nonce+counter (e.g., **ChaCha20**, **Salsa20**, **CTR-mode AES**).
- **Self‑synchronizing** (ciphertext feedback): keystream can depend on a window of previous ciphertext bits (e.g., **CFB** mode).

### Properties & pitfalls

- **Low latency / fine‑grained**: good for streaming, real‑time protocols.
- **Never reuse (key, nonce)** pair → otherwise you leak `P1 XOR P2` (two‑time pad problem).
- **No built‑in integrity** → pair with a **MAC**/**AEAD**.
- **Modern choice**: **ChaCha20‑Poly1305** AEAD (robust on platforms without fast AES).

### Real‑world uses

- VPNs, secure messaging, live media encryption, or any scenario prioritizing speed and constant‑time behavior across CPUs (mobile/embedded).

---

## 4) How Hashing Works (The Logic Behind It)

A **cryptographic hash function** maps an input of any length to a fixed‑length **digest** such that it’s infeasible to reverse or find collisions.

### Desired security properties

- **Preimage resistance**: given hash `h`, hard to find any `m` with `H(m)=h`.
- **Second‑preimage resistance**: given `m`, hard to find `m' ≠ m` with same hash.
- **Collision resistance**: hard to find **any** two different inputs with the same hash (`≈ 2^(n/2)` work for `n`‑bit hashes; birthday bound).
- **Avalanche effect**: tiny input change → unpredictable, widespread changes in the output bits.

### Constructions

1. **Merkle–Damgård** (MD5, SHA‑1, **SHA‑2**)

   - Break input into blocks; feed sequentially into a **compression function** with chaining value `CV`.
   - Uses **length‑strengthening padding** (prevents some trivial collisions).
   - Susceptible to **length‑extension** attacks for naive “`H(key || msg)`” constructions → use **HMAC** for MACs.

2. **Sponge** (Keccak/**SHA‑3**, SHAKE)

   - State of size `b = r + c` (rate `r`, capacity `c`).
   - **Absorb**: XOR input blocks into the **rate** then permute; **Squeeze**: read output from rate, optionally continue permuting for more output.
   - Naturally supports **XOFs** (extendable‑output functions) and flexible domain separation.

3. **Tree / Parallel** (BLAKE3)
   - Splits input into chunks, hashes in parallel, combines via a tree (fast on multicore systems).

### Keyed uses built on hashes

- **HMAC** (`H((K ⊕ opad) || H((K ⊕ ipad) || msg))`) → authentication/integrity with a shared key; safe against length‑extension.
- **Password storage → KDFs**: **Argon2id** (preferred), **scrypt**, **bcrypt** with **unique salts** and strong parameters; optionally add a **pepper** stored in KMS/HSM.
- **Signatures**: sign a **hash** of the message (RSA‑PSS, ECDSA, Ed25519).

### What to avoid

- **MD5** and **SHA‑1**: practical collision attacks exist. Use **SHA‑256/512**, **BLAKE2/3**, or **SHA‑3** instead.

---

## 5) Choosing Between Block vs Stream (and Where Hashing Fits)

| Goal                                  | Recommended primitive                  | Notes                                                                   |
| ------------------------------------- | -------------------------------------- | ----------------------------------------------------------------------- |
| Confidentiality + Integrity (general) | **AEAD**: AES‑GCM or ChaCha20‑Poly1305 | Prefer AEAD over “encrypt‑then‑MAC” unless you must interop with legacy |
| Low‑latency streaming on diverse CPUs | **ChaCha20‑Poly1305**                  | Avoid nonce reuse; ideal on mobile/embedded                             |
| Disk/sector encryption                | **AES‑XTS**                            | Non‑AEAD; pair with a separate integrity scheme if needed               |
| Legacy interop                        | AES‑CBC + HMAC                         | Ensure random IV, correct padding, and strong MAC                       |
| Integrity only                        | **Hash** (SHA‑256/512, BLAKE3)         | Publish checksums for files/artifacts                                   |
| Password storage                      | **KDF**: Argon2id / bcrypt / scrypt    | Use unique salt; tune memory/time cost; consider pepper                 |

---

## 6) Common Pitfalls & How to Avoid Them

- **ECB mode** on images/logs → pattern leaks. Use **GCM/CTR** instead.
- **Nonce/IV reuse** in CTR/GCM → catastrophic key‑stream reuse and tag forgeries.
- **“Encrypt‑only” without integrity** → malleability attacks. Use **AEAD**.
- **Fast hashes for passwords** → enables brute‑force. Use **Argon2id/bcrypt/scrypt** with salts.
- **Rolling your own crypto** → use vetted libs (libsodium/NaCl, BoringSSL/OpenSSL with safe defaults).
- **Key management** → store keys in **KMS/HSM**, rotate, limit access; never hard‑code in repos.
- **Side‑channels** → constant‑time code, no secret‑dependent branches/table lookups.

---

## 7) Mini Pseudocode (for Intuition)

### CTR mode (block cipher ⇒ stream)

```
nonce = unique_per_key()
for block_index i = 0..N:
    S_i = Encrypt_block(key, nonce || i)   # keystream block
    C_i = P_i XOR S_i
```

### AEAD sketch (ChaCha20‑Poly1305)

```
S = ChaCha20(key, nonce)         # keystream for encryption
C = P XOR S
tag = Poly1305(key2, AAD || C)   # integrity over AAD + ciphertext
```

### Merkle–Damgård hash (very high level)

```
CV = IV
for each block m_i:
    CV = Compress(CV, m_i)
digest = Finalize(CV, length)
```

---

## 8) Quick Reference

- **Block ciphers**: AES (SPN), DES/3DES (Feistel), Camellia.
- **Modes**: GCM/CTR/CCM/OCB (stream‑like), CBC/CFB/OFB (legacy), XTS (storage).
- **Stream ciphers**: ChaCha20, Salsa20, (RC4 deprecated), AES‑CTR as stream.
- **Hashes**: SHA‑256/512, SHA‑3 (Keccak), BLAKE2/3.
- **MACs/KDFs**: HMAC; Argon2id, scrypt, bcrypt.

---

## 9) Conclusion

- **Block ciphers** offer strong building blocks; pick safe **modes**, manage nonces, and prefer **AEAD**.
- **Stream ciphers** are excellent for speed and simplicity—**never reuse (key, nonce)**.
- **Hashing** underpins integrity and identity; for passwords, always use **KDFs** with salts (and ideally a pepper).
