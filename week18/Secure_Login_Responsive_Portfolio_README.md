# Secure Login & Responsive Portfolio — README

A concise, developer-friendly README for:

1. Building a secure login/registration portal, and
2. Optimizing a portfolio site for mobile with modern responsive techniques.

---

## 1) Secure Login & Registration Portal

### 🎯 Goals

- Protect user data at rest and in transit
- Prevent common web vulns (OWASP Top 10)
- Provide smooth UX: signup, login, logout, email verification, password reset, MFA

### 🏗️ Reference Architecture

- **Frontend:** HTML/CSS/JS (or React/Vue)
- **Backend:** Node/Express **or** Laravel **or** Django
- **DB:** PostgreSQL/MySQL (row-level encryption optional)
- **Cache/Rate-limit:** Redis
- **Auth:** Server-side sessions (HTTP-only, SameSite) **or** JWT (short TTL + rotation)

### 🔐 Security Checklist

- HTTPS, HSTS
- Strong password hashing (Argon2id / bcrypt)
- MFA support
- Email verification
- CSRF protection
- Rate limiting and lockouts
- Input validation and output encoding
- Secure headers (CSP, HSTS, etc.)
- Secure password reset flow
- Logging, monitoring, and alerts

### 🧪 API Endpoints

```
POST   /api/auth/register
POST   /api/auth/login
POST   /api/auth/logout
POST   /api/auth/forgot-password
POST   /api/auth/reset-password
GET    /api/auth/me
```

---

## 2) Mobile-First Responsive Portfolio

### 🎯 Goals

- Fast and mobile-optimized design
- Responsive across all device sizes
- Improved Core Web Vitals (LCP, CLS, INP)

### 📱 Core Techniques

- Mobile-first CSS + media queries
- Flexbox/Grid layout
- Fluid typography using `clamp()`
- Responsive images using `srcset` & `sizes`
- Meta viewport for scaling
- Accessibility-friendly components

### ⚡ Performance Tips

- Inline critical CSS
- Lazy loading images
- Minify JS/CSS
- Use CDN + caching
- Optimize web fonts
- Lighthouse audits for speed and UX

---

## 🧩 Example CSS Snippet

```css
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
  gap: 1rem;
}

@media (min-width: 768px) {
  .hero {
    display: grid;
    grid-template-columns: 1.2fr 1fr;
    align-items: center;
  }
}
```

---
