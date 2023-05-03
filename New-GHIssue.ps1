param(
    [string]$Repository,
    [string]$Token,
    [string]$Title,
    [string]$Content
)

$headers = @{
    Authorization = "token $token"
}

$body = @{
    title = $IssueTitle
    body = $content
} | ConvertTo-Json

Invoke-RestMethod -Method Post -Headers $headers -Body $body -ContentType "application/json" -Uri "https://api.github.com/repos/$repo/issues"