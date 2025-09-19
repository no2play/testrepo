# Download EICAR from an official source (explicit, not obfuscated).
$uri = 'https://www.eicar.org/download/eicar_com-zip/?wpdmdl=8847&refresh=68cd0adc953b21758268124'
$out = 'C:\temp\eicar.com'
Invoke-WebRequest -Uri $uri -OutFile $out -UseBasicParsing
Write-Output "Downloaded to $out"
Get-FileHash $out -Algorithm SHA256
