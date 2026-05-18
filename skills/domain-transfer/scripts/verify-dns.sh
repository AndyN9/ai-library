#!/bin/bash
set -e

DOMAIN="${1:-}"
if [ -z "$DOMAIN" ]; then
  echo "Usage: bash verify-dns.sh <domain>" >&2
  exit 1
fi

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

pass() { echo -e "  ${GREEN}PASS${NC} $1"; }
fail() { echo -e "  ${RED}FAIL${NC} $1"; }

echo "=== DNS Verification for $DOMAIN ==="
echo ""

# Check A records
echo "A records (apex):"
IPS=$(dig +short "$DOMAIN" A | sort)
EXPECTED="185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153"

if [ "$IPS" = "$EXPECTED" ]; then
  pass "A records resolve to GitHub Pages IPs"
else
  fail "Found:
$IPS
Expected:
$EXPECTED"
fi
echo ""

# Check www CNAME
echo "CNAME (www):"
WWW=$(dig +short "www.$DOMAIN" CNAME)
if echo "$WWW" | grep -q "github.io$"; then
  pass "www.$DOMAIN CNAME -> $WWW"
else
  fail "www.$DOMAIN CNAME -> $WWW (expected *.github.io)"
fi
echo ""

# Check HTTPS
echo "HTTPS:"
if curl -sI "https://$DOMAIN" --max-time 10 | head -1 | grep -q "200\|301\|302"; then
  pass "$DOMAIN responds over HTTPS"
else
  fail "$DOMAIN does not respond over HTTPS"
fi

echo ""
echo "=== Done ==="
