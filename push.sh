#!/bin/bash
# ============================================================
# Lernberatung Website – GitHub Push Script
# Aufruf: ./push.sh "Beschreibung der Änderung"
# ============================================================

MESSAGE=${1:-"Website aktualisiert"}

cd "$(dirname "$0")"

# Sitemap: lastmod auf heutiges Datum setzen
TODAY=$(date +%Y-%m-%d)
sed -i "s|<lastmod>.*</lastmod>|<lastmod>$TODAY</lastmod>|g" sitemap.xml
echo "sitemap.xml aktualisiert (lastmod: $TODAY)"

echo "Änderungen werden committet..."
git add -A
git commit -m "$MESSAGE

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>"

echo "Push zu GitHub..."
git push origin main

echo "Fertig! Jetzt noch Dateien im Hostinger Dateimanager hochladen."
