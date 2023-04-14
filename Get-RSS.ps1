param(
    [string]$Url
)
# Fetch RSS from URL

$feed = Invoke-RestMethod -Uri $Url

# Create a table with the wanted information
$results = foreach ($item in $feed) {
    $title = $item.title
    $link = $item.link
    $pattern = "\b[A-Z][a-z]{2},\s\d{1,2}\s[A-Z][a-z]{2}\s\d{4}\s\d{2}:\d{2}:\d{2}\b"
    $match = $item.pubDate| Select-String -Pattern $pattern
    $date = $match.Matches.Value
    $date = [DateTime]::Parse($date)

    New-Object -TypeName PSObject -Property @{
        Title = $title
        Link = $link
        Date = $date
    }
}

# return the result
return $results