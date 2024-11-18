[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $url
)
$content = Invoke-WebRequest $url

$content.RawContent   