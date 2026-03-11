# fetch-belitt3.ps1 - Restore missing belitt3.gif from Wayback Machine
$urls = @(
    "https://web.archive.org/web/2005if_/http://www.betteremail.com/images/belitt3.gif",
    "https://web.archive.org/web/2004if_/http://www.betteremail.com/images/belitt3.gif",
    "https://web.archive.org/web/2003if_/http://www.betteremail.com/images/belitt3.gif",
    "https://web.archive.org/web/2002if_/http://www.betteremail.com/images/belitt3.gif"
)

$outPath = "be_files\belitt3.gif"

foreach ($url in $urls) {
    Write-Host "Trying $url ..."
    try {
        Invoke-WebRequest -Uri $url -OutFile $outPath -ErrorAction Stop
        $size = (Get-Item $outPath).Length
        Write-Host "  Success! Saved to $outPath ($size bytes)" -ForegroundColor Green
        break
    } catch {
        Write-Host "  Failed: $_" -ForegroundColor Yellow
    }
}

if (Test-Path $outPath) {
    Write-Host "`nDone. File saved to $outPath"
} else {
    Write-Host "`nAll attempts failed. The image may not be archived." -ForegroundColor Red
    Write-Host "You can try manually at: https://web.archive.org/web/*/http://www.betteremail.com/images/belitt3.gif"
}
