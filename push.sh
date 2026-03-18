#!/bin/bash
# ============================================================
# Lernberatung Website – GitHub Push Script
# Aufruf: ./push.sh "Beschreibung der Änderung"
# ============================================================

MESSAGE=${1:-"Website aktualisiert"}

cd "$(dirname "$0")"

echo "Änderungen werden committet..."
git add -A
git commit -m "$MESSAGE

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>"

echo "Push zu GitHub..."
git push origin main

echo "Fertig! Jetzt noch Dateien im Hostinger Dateimanager hochladen."
