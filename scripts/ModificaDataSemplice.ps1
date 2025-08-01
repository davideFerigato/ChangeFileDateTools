Add-Type -AssemblyName System.Windows.Forms

function Get-RandomTimeBetween8and20 {
    $hour = Get-Random -Minimum 8 -Maximum 20
    $minute = Get-Random -Minimum 0 -Maximum 59
    $second = Get-Random -Minimum 0 -Maximum 59
    return New-TimeSpan -Hours $hour -Minutes $minute -Seconds $second
}

$uscitaTotale = $false

while (-not $uscitaTotale) {
    $ritornaAlMenu = $false
    Clear-Host
    Write-Host "== Modifica Data File ==" -ForegroundColor Cyan
    $filesToModify = @()

    $choice = Read-Host "Vuoi modificare le date di (T)utti i file o (S)elezionarli con il cursore? [T/S]"

    if ($choice -eq "S" -or $choice -eq "s") {
        $dialog = New-Object System.Windows.Forms.OpenFileDialog
        $dialog.InitialDirectory = [Environment]::CurrentDirectory
        $dialog.Multiselect = $true
        $dialog.Title = "Seleziona file"
        $dialog.Filter = "Tutti i file|*.*"

        $result = $dialog.ShowDialog()

        if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
            foreach ($filePath in $dialog.FileNames) {
                if (Test-Path $filePath -PathType Leaf) {
                    $filesToModify += Get-Item $filePath
                }
            }

            if ($filesToModify.Count -eq 0) {
                Write-Host "Nessun file valido selezionato. Torno al menu principale." -ForegroundColor Red
                pause
                continue
            }

            Write-Host "`nFile selezionati:" -ForegroundColor Cyan
            $filesToModify | ForEach-Object { Write-Host "$($_.FullName)" }
        }
        else {
            Write-Host "Selezione annullata. Torno al menu principale." -ForegroundColor Yellow
            pause
            continue
        }

    }
    elseif ($choice -eq "T" -or $choice -eq "t") {
        $targetFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
        $scriptName = $MyInvocation.MyCommand.Name
        $scriptBaseName = [System.IO.Path]::GetFileNameWithoutExtension($scriptName)
        $batName = "$scriptBaseName.bat"

        Write-Host "Cartella di destinazione rilevata: $targetFolder" -ForegroundColor Cyan

        $filesToModify = Get-ChildItem -Path $targetFolder -File |
            Where-Object {
                $_.Name -ne $scriptName -and $_.Name -ne $batName
            }

        if ($filesToModify.Count -eq 0) {
            Write-Host "Nessun file da modificare nella cartella." -ForegroundColor Red
            pause
            continue
        }

        Write-Host "`nFile trovati:" -ForegroundColor Cyan
        $filesToModify | ForEach-Object { Write-Host "$($_.FullName)" }
    }
    else {
        Write-Host "Scelta non valida. Riprova." -ForegroundColor Red
        pause
        continue
    }

    # Richiesta della data
    $baseDate = $null
    while (-not $baseDate) {
        $dateInput = Read-Host "Inserisci la data (gg/mm/aaaa) oppure (I)ndietro per tornare indietro [I]"

        if ($dateInput.ToLower() -eq "i") {
            Write-Host "Torno al menu principale..." -ForegroundColor Yellow
            pause
            $ritornaAlMenu = $true
            break
        }

        try {
            $baseDate = [datetime]::ParseExact($dateInput, 'dd/MM/yyyy', $null)
        }
        catch {
            Write-Host "ERRORE: data non valida. Riprova o digita (I)ndietro per tornare indietro [I]." -ForegroundColor Red
        }
    }

    if ($ritornaAlMenu) {
        continue  # torna al while esterno (menu T/S)
    }

    # Applica modifica se la data è valida
    foreach ($file in $filesToModify) {
        try {
            $randomTime = Get-RandomTimeBetween8and20
            $finalDateTime = $baseDate + $randomTime

            $file.CreationTime = $finalDateTime
            $file.LastWriteTime = $finalDateTime
            $file.LastAccessTime = $finalDateTime

            Write-Host "OK $($file.FullName) --> $finalDateTime" -ForegroundColor Green
        }
        catch {
            Write-Host "ERRORE su $($file.FullName): $($_.Exception.Message)" -ForegroundColor Red
        }
    }

    Write-Host "`nOperazione completata." -ForegroundColor Cyan
    $repeat = Read-Host "Vuoi modificare altri file? (S/N)"
    if ($repeat -ne "S" -and $repeat -ne "s") {
        $uscitaTotale = $true
    }
}

Write-Host "Uscita dallo script." -ForegroundColor Cyan
pause
