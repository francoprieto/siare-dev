# Verifica si Scoop está instalado
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Scoop no está instalado. Instalando Scoop..." -ForegroundColor Yellow
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    irm get.scoop.sh | iex
} else {
    Write-Host "Scoop ya está instalado." -ForegroundColor Green
}

# Agrega el bucket 'extras' si no existe
if (-not (scoop bucket list | Select-String -Pattern "^extras$")) {
    Write-Host "Agregando el bucket 'extras'..." -ForegroundColor Yellow
    scoop bucket add extras
}

# Agrega el bucket 'java' si no existe
if (-not (scoop bucket list | Select-String -Pattern "^java$")) {
    Write-Host "Agregando el bucket 'java'..." -ForegroundColor Yellow
    scoop bucket add java
}

# Lista de herramientas disponibles
$tools = @{
    1 = "nodejs-lts"
    2 = "python"
    3 = "openjdk17"
    4 = "openjdk21"
    5 = "vscode"
    6 = "mobaxterm"
    7 = "go"
    8 = "7zip"
    9 = "notepadplusplus"
    10 = "sts"
    11 = "intellij-idea-community"
    12 = "dbeaver"
    13 = "postman"
}

function Mostrar-Menu {
    Write-Host "`n=== Menú de Instalación de Herramientas de Programación ===" -ForegroundColor Cyan
    foreach ($key in $tools.Keys) {
        Write-Host "$key. $($tools[$key])"
    }
    Write-Host "0. Salir"
}

do {
    Mostrar-Menu
    $seleccion = Read-Host "`nIngrese los números de las herramientas a instalar (separados por coma, ej: 1,3,5)"

    if ($seleccion -eq '0') {
        Write-Host "Saliendo del instalador..." -ForegroundColor Yellow
        break
    }

    $indices = $seleccion -split ',' | ForEach-Object { $_.Trim() }

    foreach ($index in $indices) {
        if ($tools.ContainsKey([int]$index)) {
            $tool = $tools[[int]$index]
            Write-Host "Instalando $tool..." -ForegroundColor Cyan
            scoop install $tool
        } else {
            Write-Host "Opción inválida: $index" -ForegroundColor Red
        }
    }

    Write-Host "`n¿Deseas instalar más herramientas?" -ForegroundColor Cyan
    $respuesta = Read-Host "Escribe S para continuar o cualquier otra tecla para salir"

} while ($respuesta -match '^[sS]$')

Write-Host "`nInstalación completada. ¡Hasta luego!" -ForegroundColor Green
