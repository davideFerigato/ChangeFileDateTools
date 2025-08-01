# Ricava il percorso della cartella dove si trova questo script
$targetFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
$scriptName = $MyInvocation.MyCommand.Name
$scriptBaseName = [System.IO.Path]::GetFileNameWithoutExtension($scriptName)
$batName = "$scriptBaseName.bat"

# Informazione per l'utente
Write-Host "Cartella di destinazione rilevata: $targetFolder" -ForegroundColor Cyan

# Scelta della modalità: Tutti (T) o Selezione manuale (S)
$choice = Read-Host "Vuoi modificare le date di (T)utti i file o (S)elezionare manualmente i file contenuti nella cartella rilevata? [T/S]"

$filesToModify = @()

if ($choice -eq "S" -or $choice -eq "s") {
    Write-Host "Modalità selezione attiva. Digita il nome di ciascun file (invio dopo ognuno)." -ForegroundColor Yellow
    Write-Host "Digita 'stop' per terminare la selezione." -ForegroundColor Yellow

    while ($true) {
        $input = Read-Host "→ Inserisci nome del file (relativo alla cartella dello script)"
        if ($input.ToLower() -eq "stop") {
            break
        }

        $filePath = Join-Path $targetFolder $input
        if (Test-Path $filePath -PathType Leaf) {
            $filesToModify += Get-Item $filePath
            Write-Host "✔ Aggiunto: $filePath" -ForegroundColor Green
        } else {
            Write-Host "✘ File non trovato: $filePath" -ForegroundColor Red
        }
    }

    if ($filesToModify.Count -eq 0) {
        Write-Host "Nessun file valido selezionato. Uscita." -ForegroundColor Red
        pause
        exit
    }
}
else {
    # Modalità TUTTI (default)
    $filesToModify = Get-ChildItem -Path $targetFolder -File |
        Where-Object {
            $_.Name -ne $scriptName -and $_.Name -ne $batName
        } # ← graffa chiusa aggiunta qui
}

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

# Modifica dei file selezionati
$filesToModify | ForEach-Object {
    try {
        $randomTime = Get-RandomTimeBetween8and20
        $finalDateTime = $baseDate + $randomTime

        # Aggiorna le date del file
        $_.CreationTime = $finalDateTime
        $_.LastWriteTime = $finalDateTime
        $_.LastAccessTime = $finalDateTime

        Write-Host "OK: $($_.FullName) → $finalDateTime" -ForegroundColor Green
    }
    catch {
        Write-Host "ERRORE su: $($_.FullName) - $($_.Exception.Message)" -ForegroundColor Red
    }
}

pause
