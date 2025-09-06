# HTTPS Deep Dive: TLS 1.2 Handshake vs QUIC (HTTP/3)

**Author:** Amal P. • **Date:** 06 September 2025  
**Use:** Coursework report

---

## Summary

- **HTTPS** = HTTP over a secure transport. Traditionally this is **HTTP/1.1 or HTTP/2 over TLS 1.2/1.3 on TCP**. Modern **HTTP/3 runs over QUIC (UDP)** and embeds **TLS 1.3** inside QUIC.
- **TLS 1.2 over TCP** (full handshake): typically **3 RTT** before first application byte (1 RTT for TCP + ~2 RTT for TLS). Session resumption can cut this.
- **QUIC (HTTP/3)**: integrates **TLS 1.3** with transport → **1 RTT** handshake (and **0‑RTT** on resumption), eliminates TCP’s **head‑of‑line (HoL)** blocking, supports **connection migration**, and encrypts almost all transport metadata.

---

## 1) The HTTPS Stack (End‑to‑End Flow)

1. **URL & DNS**: Browser resolves `example.com` to IP (A/AAAA), may fetch DNS over HTTPS (DoH).
2. **Transport setup**:
   - **TCP path** → 3‑way handshake (SYN → SYN‑ACK → ACK).
   - **QUIC path** → no TCP; QUIC Initial packet over **UDP/443** starts TLS 1.3 inside QUIC.
3. **Security handshake**:
   - **TLS 1.2/1.3** over TCP **or** **TLS 1.3 over QUIC**: authenticate server, agree keys.
4. **HTTP application**:
   - **HTTP/1.1** (text), **HTTP/2** (binary frames, multiplexing, HPACK) over TLS/TCP.
   - **HTTP/3** (binary frames, multiplexing, QPACK) over **QUIC**.
5. **Request/Response**: Encrypted request sent; server responds; persistent connection, ALPN chooses HTTP version.
6. **Termination**: Close/idle timeouts; session tickets for resumption.

---

## 2) TLS 1.2 Full Handshake (over TCP) — Message Flow

Assume ECDHE for forward secrecy and server‑only authentication (most common on the web).

```
Client                                           Server
------                                           ------
TCP 3-way handshake (SYN, SYN-ACK, ACK)     # 1 RTT
ClientHello  ----------------------------->  # ciphers, versions, SNI, ALPN, extensions

                                 ServerHello  # picks version/cipher
                                 Certificate  # server cert chain
                          ServerKeyExchange  # ECDHE params (server's ephemeral key)
                         CertificateRequest  # optional (client auth)
                           ServerHelloDone
                    <-----------------------------
ClientKeyExchange  ----------------------------->  # client's ephemeral ECDH key
Certificate (opt) ----------------------------->
CertificateVerify(opt) ----------------------->  # proves possession of client's key
ChangeCipherSpec  ----------------------------->
Finished           ----------------------------->  # first message under negotiated keys

                                       ChangeCipherSpec
                    <-----------------------------
                                       Finished
```

- After the server’s **Finished**, both sides share session keys ⇒ application data (HTTP) can flow.
- **Key derivation**: ECDHE shared secret → TLS PRF → master secret → traffic keys (enc + MAC).
- **ALPN** negotiates HTTP/2 vs HTTP/1.1 (`h2` / `http/1.1`).

**RTT cost (typical full):** TCP (1 RTT) + TLS (≈2 RTT) ⇒ **~3 RTT** before first request byte.  
**Abbreviated handshake** (session ID/session ticket): can reduce TLS to **~1 RTT** after TCP.

> **Pitfalls:** Reusing non‑FS suites (no ECDHE) loses forward secrecy; wrong order of `ChangeCipherSpec/Finished`; cert chain/revocation issues; SNI/ALPN mismatches; CBC/RC4 legacy suites; server time skew breaking OCSP stapling.

---

## 3) QUIC & HTTP/3 — What Changes?

**QUIC** is a UDP‑based, encrypted, multiplexed transport that **integrates TLS 1.3** for its cryptography. **HTTP/3** is HTTP mapped onto QUIC streams.

### Key Differences vs TLS 1.2 over TCP

- **Handshake latency**: QUIC + TLS 1.3 typically **1 RTT**; **0‑RTT** possible on resumption (with replay caveats). No separate TCP handshake.
- **Multiplexing without transport HoL**: independent **streams** avoid TCP’s head‑of‑line blocking across requests (loss on one stream doesn’t stall others).
- **Connection migration**: QUIC **Connection IDs** allow seamless movement across IPs/ports (Wi‑Fi → 4G) without a new handshake.
- **Encrypted transport metadata**: most headers (packet numbers, ACKs, etc.) are encrypted/authenticated; better ossification resistance.
- **Congestion & loss recovery in user space**: faster iteration (RACK‑TLP‑style) than kernel TCP; per‑stream flow control.
- **Version negotiation** and extensibility baked in.
- **Header compression**: **QPACK** (HTTP/3) designed to avoid HoL issues seen with **HPACK** over TCP in HTTP/2.

### QUIC Handshake (with TLS 1.3) — Message Flow

```
Client (UDP/443)                                 Server
----------------                                 ------
Initial:  ClientHello  ----------------------->  # in QUIC CRYPTO frames (Initial keys)
                                   (HelloRetryRequest?)  # if needed for key shares
        <-----------------------  Initial/Handshake: ServerHello
                                  EncryptedExtensions, Certificate,
                                  CertificateVerify, Finished       # TLS 1.3
Handshake: Finished  ----------->
1-RTT data begins  <===========>  # application data over encrypted streams
(Optional) 0-RTT: Early Data --->  # only on resumption; replay risks; server may reject
```

- Packet number spaces: **Initial**, **Handshake**, **0‑RTT**, **1‑RTT** (separate keys).
- **Keys evolve** as TLS progresses; short‑header packets after handshake.
- **ALPN** still decides HTTP/3 (`h3`) vs other protocols.

**RTT cost (fresh):** typically **1 RTT** to send/receive application data.  
**Resumption:** client may send **0‑RTT** early data with last session ticket (server must enable and protect against replay).

> **Pitfalls:** UDP blocked/middlebox interference → fallback to TLS/TCP; 0‑RTT replay; mis‑configured QUIC versions; QPACK dynamic table synchronization errors; NAT rebinding without stable Connection IDs.

---

## 4) Improvements of QUIC (HTTP/3) Over TLS 1.2 (TCP)

| Area                  | TLS 1.2 over TCP              | QUIC (TLS 1.3 over UDP)                      |
| --------------------- | ----------------------------- | -------------------------------------------- |
| Handshake latency     | ~3 RTT initial (TCP + TLS)    | **1 RTT** (fresh), **0‑RTT** (resumed)       |
| Head‑of‑Line blocking | **Yes** across streams (TCP)  | **No** at transport; per‑stream delivery     |
| Connection migration  | New TCP connection needed     | **Built‑in** via Connection IDs              |
| Packet loss recovery  | Kernel TCP (RTO, SACK, etc.)  | User‑space, faster iteration (RACK/TLP‑like) |
| Transport metadata    | Largely plaintext headers     | **Encrypted/authenticated** headers          |
| Extensibility         | Hard (middlebox ossification) | Version‑negotiated, extensible               |
| Header compression    | HPACK (HTTP/2)                | **QPACK** (HoL‑resistant)                    |

> Note: Many latency gains also come from **TLS 1.3** itself (fewer flights). QUIC mandates TLS 1.3 and adds transport‑level advantages.

---

## 5) Side‑by‑Side Timelines (first byte of HTTP request)

```
TLS 1.2 over TCP (full):
RTT1: TCP 3-way
RTT2: ClientHello  ->  ServerHello+Cert+...
RTT3: ClientKeyEx+Finished  ->  Server Finished
RTT4: HTTP request begins

QUIC (fresh):
RTT1: Client Initial (CH)  ->  Server Hello+Cert+Finished
      Client Finished      ->  (same RTT) 1-RTT keys ready
      HTTP/3 request can begin

QUIC (resumed, 0-RTT):
RTT0: Client Initial + Early-Data (HTTP/3 request)
RTT1: Server accepts early data and responds
```

---

## 6) What to Look for in Wireshark

- **TLS 1.2/TCP**: filter `tcp.port == 443 and tls`. Look for `ClientHello`, `ServerHello`, `Certificate`, `ChangeCipherSpec`, `Finished`.
- **QUIC/HTTP3**: filter `udp.port == 443 and quic`. Observe `Initial`, `Handshake`, `1-RTT` packet number spaces, TLS 1.3 `CRYPTO` frames, `STREAM` frames.
- **ALPN**: `h2` (HTTP/2), `http/1.1`, or `h3` (HTTP/3).
- **Troubleshooting**: UDP blocked? You’ll see fallback to TCP/TLS (HTTP/2 or 1.1).

---

## 7) Security Notes & Best Practices

- Prefer **TLS 1.3** where possible (fewer round trips, forward secrecy by default).
- For TLS 1.2, choose **ECDHE** suites with AEAD (e.g., AES‑GCM); avoid CBC/RC4.
- Validate certificates (chain, hostname, expiry, OCSP/CRL).
- For QUIC 0‑RTT: allow idempotent/GET‑like requests only due to **replay** risk.
- Monitor for **key/nonce reuse** issues and ensure high‑quality randomness.
- Enable **HSTS**, **OCSP stapling**, and modern **ALPN** configurations.
- Use well‑maintained libraries/servers (BoringSSL, OpenSSL with TLS 1.3, nginx, Envoy, Caddy) and keep them updated.

---

## 8) Quick Glossary

- **ALPN**: Application‑Layer Protocol Negotiation (`h2`/`h3`).
- **AEAD**: Authenticated Encryption with Associated Data (AES‑GCM, ChaCha20‑Poly1305).
- **Forward Secrecy**: Compromising the long‑term key doesn’t reveal past sessions (ECDHE).
- **Head‑of‑Line Blocking**: one lost packet stalls others; QUIC avoids this at transport.
- **QPACK/HPACK**: header compression for HTTP/3 and HTTP/2, respectively.
- **0‑RTT**: client can send early data on resumption (replayable).
- **Connection ID**: QUIC identifier enabling path migration.

---

## 9) Conclusion

- **TLS 1.2 over TCP** secured the web for years but incurs extra handshakes and suffers from TCP‑level HoL.
- **QUIC (HTTP/3)** embeds **TLS 1.3** to deliver faster handshakes, robust multiplexing, encrypted transport metadata, and mobility via connection migration.
- In practice, browsers negotiate the **best path**: try QUIC/HTTP/3 first; if blocked, fall back to TLS/TCP with HTTP/2/1.1.
