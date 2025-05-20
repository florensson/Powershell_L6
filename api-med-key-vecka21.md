# Lektion – Vecka 21: Anropa API med nyckel i PowerShell

Denna vecka fokuserar vi på att anropa API:er som kräver autentisering via API-nyckel (token). Du lär dig hur man skickar nyckeln korrekt, tolkar svaret (JSON) och strukturerar kod i moduler.

## Mål med lektionen

- Göra anrop till externa API:er som kräver token
- Förstå skillnaden mellan öppna API:er och nyckelskyddade
- Skicka headers och hantera parametrar
- Läsa och tolka JSON-svar i PowerShell
- Strukturera skriptet i `.ps1` och `.psm1`
- Använda `.env`-filer för att dölja API-nycklar

---

## Vad är ett API-token?

En API-nyckel (även kallad token) är en unik sträng som identifierar dig mot ett API.  
Den skickas vanligtvis i anropets header eller som parameter i URL:en.

---

## Exempel 1 – WeatherAPI.com med `.env`

1. Skapa ett konto på https://www.weatherapi.com/ och hämta din API-nyckel
2. Skapa en `.env`-fil med detta innehåll (lägg inte citationstecken):

```
WEATHER_KEY=b296d76c7c3946698de153807251905
```

3. Lägg till `.env` i `.gitignore`:

```
.env
```

4. Använd följande kod:

```powershell
# Ladda nycklar från .env
Get-Content .env | ForEach-Object {
    if ($_ -match "^(.*?)=(.*)$") {
        $name, $value = $matches[1], $matches[2]
        if (-not [System.Environment]::GetEnvironmentVariable($name)) {
            [System.Environment]::SetEnvironmentVariable($name, $value)
        }
    }
}

function Get-Weather {
    param([string]$city)

    $key = [System.Environment]::GetEnvironmentVariable("WEATHER_KEY")
    $url = "http://api.weatherapi.com/v1/current.json?key=$key&q=$city"

    $response = Invoke-RestMethod -Uri $url
    return $response.current.temp_c
}

# Anropa funktionen
Get-Weather -city "Stockholm"
```

---

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

# Anropa
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

## Tips vid fel

- Kontrollera att nyckeln är rätt
- Kolla om nyckeln ska ligga i URL eller headers
- Kontrollera API-dokumentationen
- Testa manuellt i webbläsare eller Postman

---

## Klar?

- Registrera dig hos ett API
- Testa ett fungerande anrop i PowerShell
- Strukturera i `.ps1` och (valfritt) `.psm1`
- Lägg upp i GitHub-repo
- Lägg `.env` i `.gitignore`
