#!/usr/bin/python3

import requests
import sys

BOT_TOKEN = 'TU TOKEN DE BOT'

def send_telegram_message(chat_id, subject, message):
    url = f'https://api.telegram.org/bot{BOT_TOKEN}/sendMessage'
    payload = {
        'chat_id': chat_id,
        'text': f'*{subject}*\n{message}',
        'parse_mode': 'Markdown'
    }
    response = requests.post(url, json=payload)
    if response.status_code == 200:
        print(f'Mensaje enviado a Telegram. Chat ID: {chat_id}')
    else:
        print(f'Error al enviar mensaje a Telegram: {response.text}')

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Uso: telegram.py <chat_id> <asunto> <mensaje>")
        sys.exit(1)

    chat_id = sys.argv[1]
    subject = sys.argv[2]
    message = sys.argv[3]
    send_telegram_message(chat_id, subject, message)
