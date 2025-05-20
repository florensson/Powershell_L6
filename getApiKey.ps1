function Get-Weather {
    param([string]$city)

    $key = "b296d76c7c3946698de153807251905"
    $url = "http://api.weatherapi.com/v1/current.json?key=$key&q=$city"

    $response = Invoke-RestMethod -Uri $url
    return $response.current.temp_c
}

# Anropa funktionen
Get-Weather -city "Stockholm"
