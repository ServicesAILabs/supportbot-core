# Wichtige Projektentscheidungen

## 2024-07-01: E-Mail-Parsing-Strategie
**Optionen**:
1. Vollständige NLP-Verarbeitung (zu komplex für MVP)
2. Regex-basierte Befehlserkennung (einfach, schnell)

**Entscheidung**: Regex-Ansatz  
**Begründung**: 
- Ermöglicht schnellen Prototypen
- 80/20-Lösung für initiale Befehle
- Einfache Erweiterung später möglich

```mermaid
pie
    title Entscheidungskriterien
    “Geschwindigkeit“ : 45
    “Einfachheit“ : 35
    “Erweiterbarkeit“ : 20
```