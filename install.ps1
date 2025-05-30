## Antes de ejecutar, escriba el siguiente comando:
## Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

Write-Host "Presione la tecla [ENTER] para instalar scoop.."
Read-Host

$scoop_home = "$HOME\scoop"

if (Test-Path -Path $scoop_home -PathType Container) {
	Write-Host "Scoop ya se encuentra instalado.."
} else {
	Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

scoop update

Write-Host "Instalando git.."

scoop install git

Read-Host