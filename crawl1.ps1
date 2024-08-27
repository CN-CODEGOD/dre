[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $url
)
$content = curl $url

$content.RawContent   