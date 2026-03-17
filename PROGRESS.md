# Progress - Lernberatung Website

## Status (17.03.2026)

### Erledigt heute – Textüberarbeitung nach Andrea's PDF-Korrekturen

**index.html:**
- Intro-Text "Das Problem": "oft sind die Grundvoraussetzungen für erfolgreiches Lernen blockiert"
- Problem-Karte 1: "Hausaufgaben werden zum täglichen Kampf?" (ersetzt "Mein Kind liest kaum...")
- Problem-Karte 2+3: neue Texte (Klavier-Metapher, Prüfungsangst erweitert)
- Lernberatung-Karte: neue Beschreibung (alle Methoden aufgelistet)
- wingwave-Coaching → **Emotionscoaching** (Titel + Text)
- Methoden-Leiste: wingwave → emTrace®, Kinesiologie → wingwave, NLP-Untertitel → Kommunikation
- Ergebnisse "Schulisch & geistig": Reihenfolge korrigiert, LRS → Legasthenie
- Über Mich: "emotionalen Blockaden wie Prüfungs- und Redeangst" + neuer Absatz ergänzt
- "Für Wen?": "Insbesondere: Schüler mit..." entfernt

**methoden.html:**
- Überall erste Person (ich/meine) statt "Andrea Büchner"
- BrainGym: Sitzungs-Box erste Person, "Geeignet für:" entfernt
- wingwave: neuer Untertitel + Beschreibungstext
- emTrace-Box: "Integratives Emotionscoaching" + neuer Text, "Geeignet für:" entfernt
- Biofeedback-Box: "Muskeltest / Myostatik-Test" + neuer Text, "Geeignet für:" entfernt
- NLP: Wortlaut aktualisiert
- Kommunikation: "verstehen" statt "nach Watzlawick", erste Person, "Geeignet für:" entfernt
- "Keine Methode steht allein": erste Person

**Offener Punkt:**
- Über Mich: zwei ähnliche "Meine Arbeit verbindet..."-Absätze → klären ob alter entfernt werden soll

---

## Status (16.03.2026)

### Erledigt heute
- VPS-Vorschau eingerichtet: `https://srv825520.hstgr.cloud` → volle Seite sichtbar
- Git-Repo liegt auf VPS unter `/docker/lernberatung-website/`
- Update-Befehl: `cd /docker/lernberatung-website && git pull origin main`
- Wartungsseite auf Hostinger Shared Hosting wiederhergestellt (`wartung.html` als `index.html`)
- SSL-Zertifikat auf Hostinger aktiv (Lifetime SSL)

### Offenes Problem
- **Chrome unter Ubuntu** zeigt "Nicht sicher" für `lernberatung-buechner.de`
- Inkognito-Fenster: kein Problem → reines Cache-Problem
- Handy (Mobilfunk): kein Problem → kein DNS-Problem
- Bisherige Versuche ohne Erfolg:
  - `chrome://net-internals/#dns` → Clear host cache
  - `sudo resolvectl flush-caches`
  - Chrome neu starten
- **Nächster Schritt:** Chrome komplett zurücksetzen oder Browserdaten für die Domain löschen

### Aktueller Stand der Website
- `lernberatung-buechner.de` → Hostinger Shared Hosting → wartung.html (Wartungsseite)
- `srv825520.hstgr.cloud` → VPS → volle Vorschau-Seite für Andrea
- Texte noch nicht final freigegeben → Wartungsseite bleibt aktiv
