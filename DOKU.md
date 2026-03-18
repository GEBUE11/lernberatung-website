# Dokumentation – Website Lernberatung Andrea Büchner

Erstellt: März 2026 · Status: **live und abgeschlossen**

---

## 1. Projektübersicht

Website für Andrea Büchner, Pädagogische Praxis für Lernberatung & Kurzzeit-Coaching, Philippsburg.

- **Domain:** lernberatung-buechner.de
- **Kunde:** Andrea Büchner, kontakt@lernberatung-buechner.de
- **GitHub:** https://github.com/GEBUE11/lernberatung-website

---

## 2. Wo liegt die Seite?

### Produktion (live)
- **Hoster:** Hostinger Shared Hosting
- **Webserver:** LiteSpeed
- **Verwaltung:** hPanel unter hostinger.com → lernberatung-buechner.de
- **Upload:** Hostinger hPanel → Dateien → Dateimanager → Webroot (`public_html/`)
- **SSL:** Lifetime SSL von Hostinger, automatisch aktiv

### VPS-Vorschau (wird abgeschaltet)
- **Server:** srv825520.hstgr.cloud (privater VPS, läuft Traefik + Docker)
- **Container:** `lernberatung-nginx` (nginx:alpine via docker-compose.yml)
- **Repo auf VPS:** `/docker/lernberatung-website/`

---

## 3. Tech Stack

| Komponente | Details |
|-----------|---------|
| HTML | Plain HTML5, keine Frameworks |
| CSS | Bootstrap 5.3.2 + eigene Inline-Styles |
| Icons | Bootstrap Icons 1.11.3 |
| Fonts | Google Fonts: Montserrat + Nunito |
| Formular | web3forms (kein Backend nötig) |
| Hosting | Hostinger Shared Hosting |

---

## 4. Dateistruktur

```
/
├── index.html          Startseite
├── methoden.html       Methoden-Seite
├── faq.html            Häufige Fragen
├── kontakt.html        Kontaktformular
├── danke.html          Danke-Seite (nach Formular-Absenden)
├── impressum.html      Impressum
├── datenschutz.html    Datenschutzerklärung
├── wartung.html        Wartungsseite (bei Bedarf als index.html)
├── sitemap.xml         Sitemap für Google Search Console
├── .htaccess           Sicherheitskonfiguration (siehe Abschnitt 5)
├── push.sh             Deploy-Skript (GitHub + sitemap update)
├── assets/
│   ├── logo.gif        Logo Andrea Büchner
│   └── AndreaBuechner.jpg  Foto
├── nginx/conf.d/
│   └── default.conf    nginx-Config für VPS-Vorschau
└── docker-compose.yml  Docker-Setup für VPS-Vorschau
```

---

## 5. Sicherheit

### .htaccess (Hostinger Produktion)
Liegt im Webroot. Enthält:

- **HTTPS-Redirect:** HTTP wird automatisch auf HTTPS weitergeleitet
- **Redirect index.html → /:** Saubere URLs im Browser
- **Sicherheits-Header:**
  - `Strict-Transport-Security` (HSTS, 1 Jahr)
  - `Content-Security-Policy` (CSP – nur erlaubte externe Quellen)
  - `X-Frame-Options: SAMEORIGIN` (kein Clickjacking)
  - `X-Content-Type-Options: nosniff`
  - `Referrer-Policy: strict-origin-when-cross-origin`
- **Gesperrte Dateitypen:** .env, .key, .pem, .sql, .bak, .sh, .htpasswd, .git
- **Verzeichnis-Listing:** deaktiviert

**Ergebnis Security-Audit:** Note A auf securityheaders.com (Stand März 2026)

### SRI (Subresource Integrity)
Alle externen Ressourcen haben integrity-Attribute:
- Bootstrap CSS: `sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN`
- Bootstrap Icons: `sha384-tViUnnbYAV00FLIhhi3v/dWt3Jxw4gZQcNoSCxCIFNJVCx7/D55/wXsrNIRANwdD`
- Bootstrap JS: `sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL`

### Spam-Schutz Kontaktformular
Honeypot-Feld in kontakt.html: unsichtbare Checkbox `name="botcheck"`. Bots füllen sie aus → web3forms verwirft die Nachricht stillschweigend.

---

## 6. web3forms Kontaktformular

- **Endpoint:** `https://api.web3forms.com/submit`
- **Access Key:** `67bfb9a7-a619-4c1e-99e1-86dc4908bf37`
- **Dashboard:** web3forms.com (Login nötig)
- **Nach Absenden:** Weiterleitung auf `danke.html`
- **Eingang:** E-Mail an kontakt@lernberatung-buechner.de

**Versteckte Felder im Formular:**
```html
<input type="hidden" name="access_key" value="67bfb9a7-...">
<input type="hidden" name="subject" value="Neue Kontaktanfrage – Lernberatung Büchner">
<input type="hidden" name="from_name" value="Lernberatung-Buechner.de">
<input type="hidden" name="redirect" value="https://lernberatung-buechner.de/danke.html">
<input type="checkbox" name="botcheck" style="display:none;">
```

**Wichtig:** Im web3forms-Dashboard hCaptcha deaktivieren, sonst Fehlermeldung beim Absenden.

---

## 7. Befehle – Hostinger (Produktion)

Kein SSH-Zugang für Datei-Uploads – alles über den **hPanel Dateimanager**:

```
hostinger.com → hPanel → lernberatung-buechner.de → Dateien → Dateimanager
```

**Versteckte Dateien anzeigen:** Im Dateimanager oben rechts aktivieren (für .htaccess sichtbar machen).

**Wartungsseite aktivieren** (z.B. bei größeren Änderungen):
1. `index.html` umbenennen in `index-backup.html`
2. `wartung.html` umbenennen in `index.html`

**Wartungsseite deaktivieren:**
1. `index.html` (Wartung) zurück umbenennen in `wartung.html`
2. `index-backup.html` zurück umbenennen in `index.html`

---

## 8. Befehle – VPS Vorschau (srv825520.hstgr.cloud)

Verbindung per SSH:
```bash
ssh user@srv825520.hstgr.cloud
```

Neueste Version holen:
```bash
cd /docker/lernberatung-website
git pull origin main
```

Container neu starten (nach nginx-Config-Änderung):
```bash
docker-compose restart
# oder
docker exec lernberatung-nginx nginx -s reload
```

Status prüfen:
```bash
docker ps | grep lernberatung
```

---

## 9. Deploy-Workflow

### Nach jeder Änderung (lokal):
```bash
cd "/home/gb/_VSCode/Lernberatung Web-Seite"
./push.sh "Beschreibung der Änderung"
```

Das Skript:
1. Setzt `<lastmod>` in `sitemap.xml` auf heutiges Datum
2. Staged alle Änderungen (`git add -A`)
3. Committed mit der angegebenen Nachricht
4. Pusht zu GitHub

### Danach manuell:
Geänderte Dateien im **Hostinger Dateimanager** hochladen.

---

## 10. Google Search Console

- **Sitemap eingereicht:** `https://lernberatung-buechner.de/sitemap.xml`
- **Sitemap enthält:** index, methoden, faq, kontakt, impressum, datenschutz
- **Nicht in Sitemap:** danke.html, wartung.html
- **lastmod** wird automatisch bei jedem `push.sh`-Aufruf aktualisiert

---

## 11. Offene Punkte / Mögliche Erweiterungen

- Online-Terminbuchung (z.B. Calendly-Widget)
- KI-Chat-Widget
- Echtes Foto für Hero-Bereich (aktuell: AndreaBuechner.jpg)
- FAQ-Inhalte: Preise mit Andrea abstimmen
- Google Search Console: Indexierung beobachten (dauert 1–4 Wochen)
