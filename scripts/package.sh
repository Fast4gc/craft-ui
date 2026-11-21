#!/usr/bin/env bash
# Builds dist/craft-ui.skill (a zip with SKILL.md at the root, as Trae and other importers expect).
set -euo pipefail
cd "$(dirname "$0")/../skills/craft-ui"
out="../../dist/craft-ui.skill"
mkdir -p ../../dist && rm -f "$out"
if command -v zip >/dev/null; then
  zip -qr "$out" SKILL.md references assets
else
  python3 - "$out" << 'PY'
import sys, zipfile, os
with zipfile.ZipFile(sys.argv[1], "w", zipfile.ZIP_DEFLATED) as z:
    for top in ("SKILL.md", "references", "assets"):
        if os.path.isdir(top):
            for r, _, fs in os.walk(top):
                for f in fs: z.write(os.path.join(r, f))
        else:
            z.write(top)
PY
fi
echo "Built dist/craft-ui.skill"
