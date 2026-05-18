# GitHub Pages DNS Configuration

## Apex Domain (example.com)

Use **A records** pointing to GitHub Pages IPs. Must be **DNS-only** (unproxied).

| Type | Name | Value |
|---|---|---|
| A | @ | 185.199.108.153 |
| A | @ | 185.199.109.153 |
| A | @ | 185.199.110.153 |
| A | @ | 185.199.111.153 |

Optional IPv6 (AAAA):

| Type | Name | Value |
|---|---|---|
| AAAA | @ | 2606:50c0:8000::153 |
| AAAA | @ | 2606:50c0:8001::153 |
| AAAA | @ | 2606:50c0:8002::153 |
| AAAA | @ | 2606:50c0:8003::153 |

## WWW Subdomain (www.example.com)

| Type | Name | Value |
|---|---|---|
| CNAME | www | username.github.io |

## Domain Verification (optional)

If you've verified the domain in GitHub settings:

| Type | Name | Value |
|---|---|---|
| TXT | @ | _github-pages-challenge-USERNAME |

## Key Rules

- **Do NOT proxy (orange cloud) records pointing to GitHub Pages**. Cloudflare's proxy prevents Let's Encrypt from issuing certificates for your domain. GitHub needs direct DNS resolution for the HTTP-01 challenge.
- The `CNAME` file in your repository root must match the custom domain set in Pages settings.
- GitHub auto-redirects between apex and www based on the `CNAME` file content. You don't need extra redirect rules.
- GitHub Pages IPs rarely change, but if they do, GitHub publishes updates at: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-githubs-ip-addresses
