New-Item -ItemType Directory -Force -Path (Split-Path $PROFILE.CurrentUserCurrentHost -Parent)
Write-Output ". `"$env:USERPROFILE\.config\pwsh\user_profile.ps1`"" > $PROFILE.CurrentUserCurrentHost
