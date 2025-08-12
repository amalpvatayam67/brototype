# Google/Bing/DuckDuckGo OSINT Dork Cheat Sheet

Mastering search operators ("dorks") is essential for effective OSINT investigations using Google, Bing, or DuckDuckGo.

---

## 1. Site & Domain Targeting
- `site:` → Restrict results to a specific domain or subdomain.
  ```
  site:example.com
  site:blog.example.com
  ```
- `inurl:` → Find pages with specific words in the URL.
  ```
  inurl:login
  inurl:admin
  ```
- `intitle:` → Find pages with keywords in the page title.
  ```
  intitle:"index of"
  ```
- `allinurl:` / `allintitle:` → Match multiple words in the URL or title.

---

## 2. File Type & Document Search
- `filetype:` → Search for specific file formats.
  ```
  filetype:pdf site:example.com
  filetype:xls password
  ```
- `ext:` → Same as `filetype` but shorter syntax.

---

## 3. Exact Match & Phrase Search
- Quotes `" "` → Exact phrase match.
  ```
  "confidential report"
  ```
- `OR` → Search for one OR another term.
  ```
  "login" OR "sign in"
  ```

---

## 4. Exclusion & Filtering
- Minus `-` → Exclude words from results.
  ```
  site:example.com -inurl:blog
  ```
- `-filetype:` → Exclude specific file formats.

---

## 5. Indexing & Directory Exposure
- `"index of /"` → Find open directories.
- Combine with keywords:
  ```
  "index of /" "parent directory" site:example.com
  ```

---

## 6. Sensitive Info Hunting (For training & legal scopes only)
- ```
  "password" filetype:xls
  "confidential" filetype:pdf
  "database dump"
  ```

---

## 7. Cached & Archived Content
- `cache:` → View Google’s cached version.
  ```
  cache:example.com
  ```
- Wayback Machine search:
  ```
  site:archive.org example.com
  ```

---

## 8. Mixed Operators for OSINT
- `site:linkedin.com/in "job title"`
- `site:github.com "example.com"`
- `site:pastebin.com "example.com"`
- `inurl:"wp-content/uploads" site:example.com`

---

## Notes
- Always operate **within legal and authorized scopes**.
- Combine operators for more precise searches.
- Test across **Google, Bing, and DuckDuckGo** as results vary.

---
