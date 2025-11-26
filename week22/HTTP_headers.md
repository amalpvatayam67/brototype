#  HTTP Headers: Request and Security Comparison

---

##  1. Common Headers in an HTTP Request

These headers are fundamental for defining the communication parameters between the client and the server.

### Core Request Headers

| Header Name | Purpose and Usage | Example Value |
| :--- | :--- | :--- |
| **`Host`** | Identifies the server and port number of the resource being requested. **Required** for HTTP/1.1. | `www.example.com` |
| **`User-Agent`** | Identifies the client software (browser, bot, etc.) making the request. | `Mozilla/5.0 (Windows NT 10.0; Win64; x64)` |
| **`Accept`** | Tells the server what **content types the client can handle** in the response. | `text/html, application/json, */*` |
| **`Accept-Encoding`** | Tells the server what **compression algorithms** the client supports (e.g., Gzip). | `gzip, deflate, br` |
| **`Connection`** | Controls whether the network connection should remain open or close after the transaction. | `keep-alive` |
| **`Content-Type`** | Indicates the **media type of the request body** (used in POST/PUT). | `application/json` |
| **`Content-Length`** | Indicates the **size of the request body**, in bytes (used in POST/PUT). | `150` |

### Authentication and State Headers

| Header Name | Purpose and Usage | Example Value |
| :--- | :--- | :--- |
| **`Authorization`** | Carries the **credentials** for authentication (e.g., Bearer tokens). | `Bearer eyJhbGciOiJSUzI...` |
| **`Cookie`** | Carries **stored HTTP cookies** used to maintain session state. | `session_id=abc12345;` |
| **`Referer`** | Indicates the address of the **previous web page** from which the request originated. | `https://previous-site.com/products` |
| **`Cache-Control`** | Used for **caching directives** for the client and intermediate proxies. | `no-cache` or `max-age=3600` |

---

##  2. HTTP Security Prevention Headers

These response headers instruct the browser to enforce specific security policies, mitigating various web vulnerabilities.

| Header Name | Primary Attack Mitigated | Recommended Value | Security Benefit |
| :--- | :--- | :--- | :--- |
| **`Content-Security-Policy` (CSP)** | Cross-Site Scripting (XSS), Data Injection | `default-src 'self'; object-src 'none';` | Restricts content sources (scripts, styles) to trusted origins. |
| **`Strict-Transport-Security` (HSTS)** | Protocol Downgrade, Session Hijacking | `max-age=31536000; includeSubDomains` | **Forces HTTPS-only** communication after the first visit. |
| **`X-Content-Type-Options`** | MIME-Sniffing Attacks (leading to XSS) | `nosniff` | Prevents the browser from guessing the content type of files. |
| **`X-Frame-Options`** | Clickjacking | `DENY` | Controls if the page can be embedded in an `<iframe>` by another site. |
| **`Referrer-Policy`** | Sensitive Data Leakage | `strict-origin-when-cross-origin` | Limits the amount of referrer information sent to external sites. |
| **`Permissions-Policy`** | Unauthorized Feature Access | `geolocation=(self), camera=()` | Restricts access to powerful browser APIs (e.g., camera, microphone). |