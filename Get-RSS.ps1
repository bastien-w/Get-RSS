# Déclaration des paramètres du script
param(
    [string]$Url
)

# Récupération du flux RSS à partir de l'URL spécifiée
$feed = Invoke-RestMethod -Uri $Url


# Création d'un tableau de résultats contenant le titre, le lien et la date de chaque élément
$results = foreach ($item in $feed) {
    $title = $item.title
    $link = $item.link
    $date = [DateTime]::Parse($item.pubDate)

    New-Object -TypeName PSObject -Property @{
        Title = $title
        Link = $link
        Date = $date
    }
}

# Affichage des résultats dans un tableau
return $results