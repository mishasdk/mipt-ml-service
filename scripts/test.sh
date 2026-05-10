#!/usr/bin/env bash
set -euo pipefail

v1=0
v2=0

for i in {1..20}; do
  response=$(curl -s http://localhost:8080/health)
  # echo $response
  version=$(echo "$response" | grep -o '"version":"[^"]*"' | cut -d'"' -f4)
  if [ "$version" = "0.1.0" ]; then
    ((v1++))
  else
    ((v2++))
  fi
  sleep 0.1
done

total=$((v1 + v2))
echo ""
echo "v0.1.0: $v1/$total ($(( v1 * 100 / total ))%)"
echo "other:  $v2/$total ($(( v2 * 100 / total ))%)"
