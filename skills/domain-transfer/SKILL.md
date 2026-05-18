---
name: domain-transfer
description: >
  Transfers domain registration + DNS between providers while keeping sites live.
  Use when migrating a domain from any registrar (Squarespace, GoDaddy, Namecheap, etc.)
  to Cloudflare Registrar or any other target registrar.
  Use when you need to switch DNS providers without downtime.
  Use when moving a domain used by GitHub Pages, Cloudflare Pages, Netlify, or similar.
  Trigger phrases: "Transfer my domain", "Migrate from [registrar]", "Move domain registration",
  "Switch DNS providers", "Domain transfer".
---

# Domain Transfer

Transferring a domain registration from one provider to another is straightforward
if done in the right order. Do it wrong and you can cause DNS resolution failures,
HTTPS cert breakage, or a 60-day ICANN lock that prevents re-transfers.

The core insight: **DNS and registration are separate concerns**. You can (and should)
switch DNS first, verify everything works, then transfer the registration.

## Workflow

### Phase 0 — Pre-migration

- Identify the current registrar and whether they also host DNS (Squarespace, Wix, Shopify do)
- Identify the current DNS provider (often the registrar, but not always)
- Inventory all DNS records (A, AAAA, CNAME, MX, TXT, etc.)
- Decide target DNS provider (Cloudflare is the most common choice)
- Check for DNSSEC — it MUST be disabled before switching nameservers
- Check if the domain was recently transferred or WHOIS info changed (< 60 days = ICANN lock)

### Phase 1 — DNS handover

1. **Create account** at target DNS provider (e.g. Cloudflare)
2. **Add domain** to target DNS provider (Cloudflare: "Add a Site")
3. **Import DNS records** — most providers auto-scan existing records
4. **Check and fix records** — verify every record is correct. This is where the gotchas live:
   - **GitHub Pages**: A records MUST be DNS-only (gray cloud). Proxied records block Let's Encrypt cert issuance, causing HTTPS to break.
   - **Squarespace site**: If still hosted there, the `verify.squarespace.com` CNAME must be DNS-only.
   - **Email (MX)**: If using email, verify MX records are correct and non-proxied.
5. **Disable DNSSEC** at the current provider/registrar. This is critical — if DNSSEC is enabled when you switch nameservers, some resolvers will reject your DNS responses, causing resolution failures.
6. **Update nameservers** at the current registrar to point to the target DNS provider
7. **Wait for propagation** — Cloudflare shows "Active" when it detects the nameserver change. Can take minutes to hours.

### Phase 2 — Verify

1. Visit the site. Does it load? Both `example.com` and `www.example.com`?
2. Check HTTPS. Does the certificate work? Visit `/` in a browser.
3. For GitHub Pages: check the repo → Settings → Pages. DNS check should pass. "Enforce HTTPS" should be enabled.
4. Test other services (email, API endpoints, subdomains).
5. Use `dig` or `nslookup` to verify DNS resolution:
   ```bash
   dig +short example.com A
   dig +short www.example.com CNAME
   ```
6. If DNS check at GitHub Pages fails or HTTPS cert won't provision:
   - **Remove custom domain** in Pages settings
   - **Re-enter** and **Save** to re-trigger cert issuance
   - Ensure A records are **unproxied** (gray cloud) — this is the most common root cause

### Phase 3 — Registration transfer

1. At the current registrar:
   - **Disable Domain Lock** (also called Registrar Lock or Transfer Lock)
   - **Disable WHOIS Privacy** (required by ICANN for transfer)
   - **Disable DNSSEC** (if not already done in Phase 1)
   - **Request Authorization Code** (also called EPP code, authinfo, transfer code)
     - Sent via email. Some registrars take hours to send it.
2. At the target registrar:
   - Navigate to domain transfer page
   - Enter the authorization code
   - Confirm contact information (must match WHOIS data)
   - Pay the transfer fee (at-cost registrars like Cloudflare charge only ICANN fee + 1 year extension)
3. **Approve the transfer** — the current registrar will send a transfer-out confirmation email. Click the link or respond in their dashboard to expedite (otherwise auto-releases after 5 days).
4. **Wait for completion** — typically 5-7 days. Some registrars release immediately after you approve.
5. **Post-transfer**:
   - Delete the domain from the old registrar's dashboard
   - Verify the domain shows under the new registrar's domain management
   - Re-enable WHOIS privacy at the new registrar (usually auto-enabled)

## Common Gotchas

| Problem | Cause | Fix |
|---|---|---|
| Site unreachable after nameserver switch | DNSSEC still enabled at old registrar | Disable DNSSEC at old provider before switching |
| "Not available for your site" HTTPS on GitHub Pages | A records proxied through Cloudflare | Set A records to DNS-only (gray cloud) |
| Auth code never arrives | WHOIS email outdated, spam filter | Check WHOIS contact, check spam, request again |
| Transfer not allowed | < 60 days since last transfer or WHOIS change | Wait out the ICANN lock period |
| "Cannot change nameservers" | Registrar is a site-builder platform (Shopify, Wix, Squarespace) | May need intermediate transfer to a registrar that allows nameserver changes |

## When Registrars Don't Allow Nameserver Changes

Some platforms (Shopify, Wix, Squarespace for some domains) act as both registrar and
hosting platform and may prevent nameserver changes while the domain is registered there.

**Workaround**: Transfer to an intermediate registrar first (e.g., Namecheap, Porkbun)
that allows nameserver changes, then configure Cloudflare DNS there. After 60 days,
transfer again from the intermediate registrar to Cloudflare Registrar.

Note: Each transfer adds +1 year to the domain expiration date.

## Output

The domain is live on its new DNS provider and the registration is moved to the target registrar.
Old registrar dashboard is cleaned up. All services (site, email, subdomains) continue working.

## Present Results to User

Summarize:
- DNS is now managed by: {target DNS provider}
- Registration is now with: {target registrar}
- Site verified: {yes/no}
- HTTPS verified: {yes/no}
- Transfer duration: {how long it took}
- Any follow-up: {re-enable WHOIS privacy, etc.}

## Troubleshooting

**DNS resolves but site doesn't load**: Check if the A records are right and not proxied if the origin is GitHub Pages.

**HTTPS cert not provisioning**: For GitHub Pages, the Let's Encrypt challenge must see your domain resolving directly. Cloudflare proxy (orange cloud) defeats this. Switch to gray cloud.

**Transfer stuck at old registrar**: Log in and check for a pending transfer-out confirmation email or dashboard prompt. Approving it immediately releases the domain.

**Nameservers not updating**: Some registrars cache nameserver changes for hours. If Cloudflare still shows "Pending Nameserver Update" after 24 hours, contact the current registrar's support.
