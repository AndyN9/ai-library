#!/bin/bash
set -e

DOMAIN="${1:-}"
if [ -z "$DOMAIN" ]; then
  echo "Usage: bash check-transfer-status.sh <domain>" >&2
  echo "" >&2
  echo "Checks DNS propagation and transfer status for a domain being transferred to Cloudflare." >&2
  exit 1
fi

echo "=== Transfer Status for $DOMAIN ==="
echo ""

echo "1. Nameserver lookup (whois):"
NS=$(whois "$DOMAIN" 2>/dev/null | grep "Name Server:" | head -5 | awk '{print $NF}')
if echo "$NS" | grep -q "cloudflare.com"; then
  echo "   Nameservers include cloudflare.com ✓"
else
  echo "   Nameservers: $NS (no cloudflare.com detected)"
fi
echo ""

echo "2. WHOIS registrar:"
REG=$(whois "$DOMAIN" 2>/dev/null | grep -i "Registrar:" | head -3 | sed 's/.*Registrar:\s*//i')
echo "   $REG"
echo ""

echo "3. Domain lock status (from WHOIS):"
STATUS=$(whois "$DOMAIN" 2>/dev/null | grep -i "Domain Status:" | head -5)
echo "   $STATUS"
echo ""

echo "4. DNS resolution:"
if dig +short "$DOMAIN" A > /dev/null 2>&1; then
  echo "   DNS resolves ✓"
else
  echo "   DNS resolution FAILED ✗"
fi
echo ""

echo "=== Tips ==="
echo "- If Cloudflare shows 'Transfer Initiated', the auth code was accepted."
echo "- Check email from your old registrar for transfer-out confirmation."
echo "- Approving the confirmation email speeds up the process."
echo "- Transfers typically complete in 5-7 days."
echo ""
