import json
import requests

headers = {"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYzY3NzhjNzktN2QxYy00ZjYzLTlkMzItYTZkMTlkNGNiMmMzIiwidHlwZSI6ImFwaV90b2tlbiJ9.V6VjrZA3U0pb6IzhFOVTq2p7Aa46qviSp7tV54gC5dM"}

url = "https://api.edenai.run/v2/text/summarize"
payload = {
    "providers": "microsoft,connexun",
    "language": "ro",
    "text":""" Primarul a declarat că „mai mulți angajați din învățământ vor rămâne fără locul de muncă”, transmite Știri.md.

Edilul a precizat că este vorba de aprobarea „Ordinului nr. 1338, semnat, la 01 noiembrie 2023, de ministrul Educației”.

„Din 01 august 2024, vor fi disponibilizați angajați din școlile din țară. 

Ordinul semnat OBLIGĂ ca statele de personal din școli să fie ajustat în funcție de numărul de elevi. 

Cele mai afectate vor fi școlile cu până la 200 de elevi. 

Primii vizați care își vor pierde locul de muncă sunt psihologii, psihopedagogii, conducătorii de cerc, directorii adjuncți, dar și mulți alți angajați.

Documentul Guvernului OBLIGĂ administrațiile mai multor școli din municipiul Chișinău să disponibilizeze zeci de cadre didactice și auxiliare. 

Deja directorii ne contactează și întreabă ce să facă”, a declarat Ceban.""",
    "fallback_providers": ""
}

response = requests.post(url, json=payload, headers=headers)

result = json.loads(response.text)
print(result['microsoft']['result'])


print("Mэțțț")