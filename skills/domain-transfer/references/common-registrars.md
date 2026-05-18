# Registrar-Specific Instructions

## Squarespace

Squarespace acquired Google Domains in 2023. Many domains are now managed there.

- **Nameservers**: Domains → click domain → DNS → Nameservers → Custom
- **Domain Lock (Transfer Lock)**: Domains → domain → Domain Settings → toggle Domain Lock off
- **WHOIS Privacy**: Domains → domain → Domain Settings → toggle WHOIS Privacy off
- **DNSSEC**: Domains → domain → Advanced Settings → toggle DNSSEC off
- **Auth Code**: Domains → domain → ... menu → Send Transfer Authorization Code (can take hours to arrive)
- **Transfer-out**: Up to 5 days. Approve the confirmation email to expedite.

**Known issue**: Auth code emails can take 1-3 hours. Check spam folder.

## GoDaddy

- **Nameservers**: My Products → Domains → DNS → Nameservers → Change
- **Domain Lock**: My Products → Domains → domain → Domain Settings → Lock → toggle off
- **WHOIS Privacy**: My Products → Domains → domain → Domain Settings → Privacy → toggle off
- **DNSSEC**: My Products → Domains → domain → Domain Settings → DNSSEC → Manage
- **Auth Code**: My Products → Domains → domain → Domain Settings → Get Authorization Code
- **Transfer-out**: Usually releases within hours of requesting transfer.

## Namecheap

- **Nameservers**: Domain List → domain → Manage → Nameservers → Custom DNS
- **Domain Lock**: Domain List → domain → Manage → Domain → Lock Domain → toggle off
- **WHOIS Privacy**: Domain List → domain → Manage → Domain → WHOIS Privacy → toggle off
- **DNSSEC**: Domain List → domain → Manage → Advanced → DNSSEC → Disable
- **Auth Code**: Domain List → domain → Manage → Domain → Get EPP Code
- **Transfer-out**: Usually quick if transfer is approved.

## Cloudflare Registrar

Only for transfers TO Cloudflare. If transferring AWAY from Cloudflare, unlock the domain and get the auth code from Cloudflare Dashboard → Domain Registration → Manage Domain.

## Google Domains (acquired by Squarespace)

Domains were migrated to Squarespace in 2023-2024. Follow Squarespace instructions above.
Previously had nameserver settings at https://domains.google.com.

## Shopify

**Workaround needed** — Shopify may not allow nameserver changes. Transfer to a regular registrar first (Namecheap, Porkbun), wait 60 days, then transfer to Cloudflare.

## Wix

Same as Shopify — **workaround needed**. Wix doesn't expose nameserver controls while hosting DNS. Transfer to an intermediate registrar first.

## Registrars that Support Direct Transfer to Cloudflare

Cloudflare Registrar supports direct transfer from most major registrars including:
Squarespace, GoDaddy, Namecheap, Dynadot, Gandi, Hover, Name.com, OVH, Porkbun, and others.

See the full list: https://developers.cloudflare.com/registrar/get-started/transfer-domain-to-cloudflare/
