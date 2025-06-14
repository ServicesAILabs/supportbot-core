# Entscheidung: E-Mail-Parsing-Implementierung

## Kontext
Wir müssen eingehende E-Mails auf Support-Befehle analysieren.

## Evaluierte Optionen
| Methode | Vorteile | Nachteile |
|---------|----------|-----------|
| **Regex** | Einfach, schnell | Begrenzte Flexibilität |
| **NLP-Bibliothek** | Natürliche Sprache | Höhere Latenz, Komplexität |
| **LLM-Prompt** | Maximal flexibel | Teuer, langsam |

## Experimentdaten
```python
# Testdurchlauf mit 100 E-Mails
regex_success = 92  # 92% korrekte Erkennung
nlp_success = 87    # 87% bei 3x höherer Latenz
```

## Entscheidung
✅ Regex-Implementierung für MVP mit folgenden Mustern:
```python
START_PATTERN = r'\[START|BEGIN|TICKET\]'
HELP_PATTERN = r'\[HELP|INFO|SUPPORT\]'
```

## Zukünftige Verbesserungen
- NLP-Integration bei >1000 E-Mails/Monat
- Fehlermetriken in DynamoDB protokollieren