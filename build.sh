#!/bin/sh
# Builds docs/index.html from content/KorejaMain.md and src/template.html.
set -e
cd "$(dirname "$0")"
python3 build/parse.py content/KorejaMain.md build/data.json
python3 - <<'PY'
tpl = open('src/template.html', encoding='utf-8').read()
data = open('build/data.json', encoding='utf-8').read().replace('</', '<\\/')
open('docs/index.html', 'w', encoding='utf-8').write(tpl.replace('/*DATA*/', data))
PY
echo "built docs/index.html"
