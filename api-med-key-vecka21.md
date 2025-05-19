# Lektion – Vecka 21: Anropa API med nyckel i PowerShell

Denna vecka fokuserar vi på att anropa API:er som kräver autentisering via API-nyckel (token). Du lär dig hur man skickar nyckeln korrekt, tolkar svaret (JSON) och strukturerar kod i moduler.

## Mål med lektionen

- Göra anrop till externa API:er som kräver token
- Förstå skillnaden mellan öppna API:er och nyckelskyddade
- Skicka headers och hantera parametrar
- Läsa och tolka JSON-svar i PowerShell
- Strukturera skriptet i `.ps1` och `.psm1`

---

## Vad är ett API-token?

En API-nyckel (även kallad token) är en unik sträng som identifierar dig mot ett API.  
Den skickas vanligtvis i anropets header eller som parameter i URL:en.

---

## Exempel 1 – WeatherAPI.com

1. Gå till https://www.weatherapi.com/
2. Skapa ett konto och hämta din gratis API-nyckel
3. Använd följande kod:

```powershell
function Get-Weather {
    param([string]$city)

    $key = " "
    $url = "http://api.weatherapi.com/v1/current.json?key=$key&q=$city"

    $response = Invoke-RestMethod -Uri $url
    return $response.current.temp_c
}

# Anropa funktionen
Get-Weather -city "Stockholm"
```

---

Vi kan också testa i terminalen om vi vill:
```powershell
$city = "Stockholm"
$key = "b296d76c7c3946698de153807251905"
$url = "http://api.weatherapi.com/v1/current.json?key=$key&q=$city"
$response = Invoke-RestMethod -Uri $url
$response.current
```

## Exempel 2 – Med header: NewsAPI.org

1. Gå till https://newsapi.org/
2. Skapa ett konto → Få nyckel
3. Skicka nyckeln i headers:

```powershell
function Get-TopNews {
    $token = "din-api-nyckel"
    $url = "https://newsapi.org/v2/top-headlines?country=se"

    $headers = @{
        "X-Api-Key" = $token
    }

    $response = Invoke-RestMethod -Uri $url -Headers $headers
    return $response.articles[0].title
}

# Anrop
Get-TopNews
```

---

## Utforska JSON-svaret

PowerShell gör automatiskt JSON → objekt.  
För att förstå svaret:

```powershell
$response | Get-Member
$response.PSObject.Properties.Name
```

---

## Strukturera kod i modul

**Get-Weather.psm1**

```powershell
function Get-Weather {
    param([string]$city)
    $key = "din-api-nyckel"
    $url = "http://api.weatherapi.com/v1/current.json?key=$key&q=$city"
    $response = Invoke-RestMethod $url
    return $response.current.temp_c
}
```

**run.ps1**

```powershell
Import-Module ./Get-Weather.psm1
Get-Weather -city "Göteborg"
```

---

## Tips vid fel

- Kontrollera att nyckeln är rätt
- Kolla om nyckeln ska ligga i URL eller headers
- Kontrollera API-dokumentationen
- Testa manuellt i webbläsare eller Postman

---

## Klar?

- Registrera dig hos ett API
- Testa ett fungerande anrop i PowerShell
- Strukturera i modul + ps1
- Lägg upp i GitHub-repo
