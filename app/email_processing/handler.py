import re
from pydantic import BaseModel

class EmailRequest(BaseModel):
    subject: str
    body: str
    sender: str

def process_email(email: EmailRequest) -> str:
    """Verarbeitet eingehende E-Mails basierend auf Betreff-Codes"""
    # Befehlsextraktion
    command_match = re.search(r'\[(START|HELP|REPHRASE|EXIT)\]', email.subject)
    command = command_match.group(1) if command_match else None
    
    # Befehlsverarbeitung
    if command == "START":
        return "Vielen Dank! Ihr Ticket wurde eröffnet. (Ticket #123)"
    elif command == "HELP":
        return ("Verfügbare Befehle:\n"
                "[START] - Ticket eröffnen\n"
                "[REPHRASE] - Anfrage umformulieren\n"
                "[EXIT] - Konversation beenden")
    elif command == "REPHRASE":
        return "Bitte präzisieren Sie Ihre Anfrage mit mehr Details."
    else:
        return "Unbekannter Befehl. Senden Sie 'HELP' für Anleitung."