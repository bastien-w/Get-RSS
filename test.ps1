$csv = Import-Csv -Delimiter ';' -Path .\feed.csv

$yesterday8AM = (Get-Date).AddDays(-1).Date.AddHours(8)
$today8AM = (Get-Date).Date.AddHours(8)

$linkProperty = @{
    Name = "Link"
    Expression = {"`<a href=$($_.Link) target=_blank`>$($_.Title)`</a`>"}
}

foreach ($item in $csv) {
    $articles = .\Get-RSS.ps1 -Url $item.url
    $html += "<h1>$($item.Name)</h1>"
    $html += $articles | 
    Where-Object {$_.date -ge $yesterday8AM -and $_.date -lt $today8AM} | 
    Select-Object Date,$linkProperty | 
    ConvertTo-Html -Head ''
    $html = $html -replace '&lt;', '<' -replace '&gt;', '>'
}