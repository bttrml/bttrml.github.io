## 2026-03-11 - Security Hardening of Legacy Email Landing Page
**Vulnerability:** Legacy HTML page using insecure HTTP links, lacking modern security headers (CSP), and missing password field attributes.
**Learning:** Legacy pages often contain hardcoded `http://` links that bypass HTTPS even if the site is served over SSL. Content Security Policy is effective but must be carefully tuned to avoid breaking third-party scripts like Google Adsense.
**Prevention:** Always use `https://` for internal and external links. Implement a CSP with `upgrade-insecure-requests`. Add standard HTML5 attributes to sensitive inputs (autocomplete, maxlength).
