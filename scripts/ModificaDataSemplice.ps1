# Ricava il percorso della cartella dove si trova questo script
$targetFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
$scriptName = $MyInvocation.MyCommand.Name
$scriptBaseName = [System.IO.Path]::GetFileNameWithoutExtension($scriptName)
$batName = "$scriptBaseName.bat"

# Informazione per l'utente
Write-Host "Cartella di destinazione rilevata: $targetFolder" -ForegroundColor Cyan

# Richiesta della data all'utente
$dateInput = Read-Host "Inserisci la data da applicare (formato gg/mm/aaaa)"

# Validazione della data
try {
    $baseDate = [datetime]::ParseExact($dateInput, 'dd/MM/yyyy', $null)
} catch {
    Write-Host "ERRORE: data non valida. Usa il formato gg/mm/aaaa." -ForegroundColor Red
    pause
    exit
}

# Funzione per generare un orario casuale tra le 08:00 e le 20:00
function Get-RandomTimeBetween8and20 {
    $hour = Get-Random -Minimum 8 -Maximum 20
    $minute = Get-Random -Minimum 0 -Maximum 59
    $second = Get-Random -Minimum 0 -Maximum 59
    return New-TimeSpan -Hours $hour -Minutes $minute -Seconds $second
}

# Cicla su tutti i file della cartella, tranne gli script stessi
Get-ChildItem -Path $targetFolder -File |
    Where-Object {
        $_.Name -ne $scriptName -and $_.Name -ne $batName
    } | ForEach-Object {
        try {
            $randomTime = Get-RandomTimeBetween8and20
            $finalDateTime = $baseDate + $randomTime

            # Aggiorna le date del file
            $_.CreationTime = $finalDateTime
            $_.LastWriteTime = $finalDateTime
            $_.LastAccessTime = $finalDateTime

            Write-Host "OK: $($_.Name) → $finalDateTime" -ForegroundColor Green
        }
        catch {
            Write-Host "ERRORE su: $($_.FullName) - $($_.Exception.Message)" -ForegroundColor Red
        }
    }

pause