$response | Get-Member
$response.PSObject.Properties.Name

$token = "76464c5b5a3247459cfbce3cefa96e22"
$url = "https://newsapi.org/v2/top-headlines?country=us&category=technology"
$headers = @{ "X-Api-Key" = $token }

$response = Invoke-RestMethod -Uri $url -Headers $headers
$response | ConvertTo-Json -Depth 5

