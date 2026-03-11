# fetch_archive.ps1 - Fetch original BetterEmail pages from the Wayback Machine

$outDir = "$env:TEMP\betteremail"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$urls = @{
    "secure.htm"       = "https://web.archive.org/web/20050405211000id_/http://betteremail.com/secure.htm"
    "better.htm"       = "https://web.archive.org/web/20050405211016id_/http://betteremail.com/better.htm"
    "forgot_index.html"= "https://web.archive.org/web/20050405222948id_/http://betteremail.com/forgot/"
    "robots.txt"       = "https://web.archive.org/web/20050405211000id_/http://betteremail.com/robots.txt"
    "better2.htm"      = "https://web.archive.org/web/20050405211000id_/http://betteremail.com/insane/better2.htm"
}

foreach ($file in $urls.Keys) {
    $path = Join-Path $outDir $file
    Write-Host "Fetching $file..."
    try {
        Invoke-WebRequest -Uri $urls[$file] -OutFile $path -UseBasicParsing
        Write-Host "  Saved to $path ($(( Get-Item $path).Length) bytes)"
    } catch {
        Write-Host "  FAILED: $_"
    }
}

Write-Host "`n=== Results ==="
foreach ($file in $urls.Keys) {
    $path = Join-Path $outDir $file
    if (Test-Path $path) {
        Write-Host "`n--- $file ($(( Get-Item $path).Length) bytes) ---"
        Get-Content $path -Raw
        Write-Host "=== END $file ==="
    }
}
