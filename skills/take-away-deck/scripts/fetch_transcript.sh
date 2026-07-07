#!/usr/bin/env bash
# Fetch a page that blocks headless browsers (e.g. bearblog / Substack return
# HTTP 403 to Playwright's default UA) by setting a realistic desktop
# User-Agent first, using the gstack `browse` daemon.
#
# Usage: ./fetch_transcript.sh <url> [out.txt]
set -euo pipefail
URL="${1:?usage: fetch_transcript.sh <url> [out.txt]}"
OUT="${2:-transcript.txt}"
B="$HOME/.claude/skills/gstack/browse/dist/browse"

"$B" useragent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36" >/dev/null
"$B" goto "$URL" >/dev/null
"$B" wait --load >/dev/null 2>&1 || true
echo "--- network (expect a 200 on the second request, after the UA change) ---"
"$B" network | head -4
"$B" text > "$OUT"
echo "saved -> $OUT ($(wc -l < "$OUT") lines)"
