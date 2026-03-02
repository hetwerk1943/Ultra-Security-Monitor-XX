🛡️ Ultra Security Monitor X – Total Security & RTT Shield

Ultra Security Monitor X to zaawansowany system ochrony i monitorowania dla Windows 10/11 (64-bit), stworzony z myślą o pełnej kontroli nad bezpieczeństwem w czasie rzeczywistym. Łączy funkcje EDR (Endpoint Detection & Response), IDS (Intrusion Detection System), ochrony przed Ransomware, monitoringu integralności plików, ochrony prywatności RTT Shield oraz integracji z systemami SIEM.

🎯 Cel projektu

Celem projektu jest stworzenie pełnego ekosystemu bezpieczeństwa, który:

chroni przed malware, ransomware, keyloggerami i rootkitami,

monitoruje procesy, połączenia sieciowe i zmiany w systemie,

zapewnia automatyczne backupy i wersjonowanie krytycznych plików,

umożliwia integrację z SIEM i narzędziami DevOps,

wprowadza ochronę prywatności RTT Shield przed fingerprintingiem czasowym i analizą ruchu sieciowego.

🔑 Kluczowe funkcje

Core Security Engine – monitorowanie procesów, analiza podpisów cyfrowych, hashy SHA-256, logowanie zdarzeń.

masterAgent – orchestrator wszystkich modułów systemu, koordynacja pracy i automatyczny restart procesów.

Audit-Project – narzędzie do audytu struktury repozytorium i integralności plików.

RTT Shield – zaawansowana ochrona prywatności, losowe opóźnienia, maskowanie sygnatur sieciowych, wykrywanie sond i nietypowych handshake’ów.

Backup & Versioning – automatyczne tworzenie backupów każdej zmiany w krytycznych folderach.

Dashboard HTML/JS – podgląd logów, analiza trendów i alertów w lokalnym, lekkim panelu webowym.

SIEM Integration – NDJSON logi kompatybilne z Splunk, ELK Stack i Graylog, automatyczne raporty i alerty.

Alerty i powiadomienia – natychmiastowe powiadomienia na Discord, E-mail oraz dźwiękowe alerty krytycznych zdarzeń.

⚙️ Architektura

Projekt jest podzielony na moduły:

UltraSecurityMonitor.ps1 – główny silnik EDR + IDS + Ransomware

masterAgent.ps1 – orchestrator

Audit-Project.ps1 – audyt projektu

RTT-Shield/ – moduły ochrony prywatności: RTTShield.ps1, EntropyEngine.ps1, ProbeDetection.ps1, NetworkSmoothing.ps1

SIEM/ – logi bezpieczeństwa (NDJSON)

Backup/ – automatyczne backupy plików

dashboard.html – panel wizualizacji bezpieczeństwa

package.json – konfiguracja frontendu i CI/CD

🛡️ Bezpieczeństwo i prywatność

RTT Shield chroni przed RTT Trackingiem i timing fingerprintingiem.

Wszystkie logi i alerty przechowywane lokalnie lub wysyłane przez bezpieczne kanały.

Brak przesyłania danych użytkownika do serwerów zewnętrznych bez zgody.

💻 Wymagania systemowe

Windows 10/11 (64-bit)

PowerShell 5.1+

Konto Administratora

Połączenie internetowe opcjonalnie (Discord, VirusTotal)

Dowolna nowoczesna przeglądarka dla dashboardu

📄 Licencja

Projekt udostępniany na licencji MIT License (LifeHub Team, 2026) – pozwala na użycie, kopiowanie, modyfikację i dystrybucję bez ograniczeń.
