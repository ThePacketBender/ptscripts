#Usage: echo "" | powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -File wget.ps1
echo $storageDir = $pwd > wget.ps1
echo $webclient = New-Object System.Net.WebClient >> wget.ps1
echo $url = "[---URL (with filepath)---]" >> wget.ps1
echo $file = "[---saved file name---]" >> wget.ps1
echo $webclient.DownloadFile($url,$file) >> wget.ps1
