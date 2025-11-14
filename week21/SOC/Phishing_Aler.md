Incident: SOC282 – Deceptive Email Detected
Category: Phishing
Severity: Medium

Sender domain “coffeeshoo0op.com” is suspicious and newly registered.
Email subject “Free Coffee Voucher” designed to lure user.

IOC:
103.80.134.63 (SMTP IP)
coffeeshoo0op.com (malicious domain)

Result:
TRUE POSITIVE

Action Taken:

- Block sender domain
- Warn user
- Quarantine similar emails
