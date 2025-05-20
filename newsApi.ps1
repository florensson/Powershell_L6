function Get-TopNews {
    $token = "76464c5b5a3247459cfbce3cefa96e22"
    $url = "https://newsapi.org/v2/top-headlines?country=us&category=technology"

    $headers = @{
        "X-Api-Key" = $token
    }

    $response = Invoke-RestMethod -Uri $url -Headers $headers
    return $response.articles[0].title
}

# Anrop
Get-TopNews

