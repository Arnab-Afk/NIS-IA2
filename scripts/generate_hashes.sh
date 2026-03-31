#!/usr/bin/env bash
set -euo pipefail

# Generate reproducible sample hashes for a safe classroom demo.
mkdir -p samples

# Username:Hash format works directly with John.
{
  echo "alice:$(openssl passwd -1 -salt saltA secret123)"
  echo "bob:$(openssl passwd -5 -salt saltB admin123)"
  echo "charlie:$(openssl passwd -6 -salt saltC letmein)"
} > samples/password_hashes.txt

echo "Created samples/password_hashes.txt"
