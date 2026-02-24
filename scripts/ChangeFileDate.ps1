Add-Type -AssemblyName System.Windows.Forms

function Get-RandomTimeBetween8and20 {
    $hour = Get-Random -Minimum 8 -Maximum 20
    $minute = Get-Random -Minimum 0 -Maximum 59
    $second = Get-Random -Minimum 0 -Maximum 59
    return New-TimeSpan -Hours $hour -Minutes $minute -Seconds $second
}

$globalExit = $false

while (-not $globalExit) {
    $backToMenu = $false
    Clear-Host
    Write-Host "== File Date Modifier ==" -ForegroundColor Cyan
    $filesToModify = @()

    $choice = Read-Host "Do you want to modify (A)ll files in this folder or (S)elect them manually? [A/S]"

    if ($choice -eq "S" -or $choice -eq "s") {
        $dialog = New-Object System.Windows.Forms.OpenFileDialog
        $dialog.InitialDirectory = [Environment]::CurrentDirectory
        $dialog.Multiselect = $true
        $dialog.Title = "Select files"
        $dialog.Filter = "All files|*.*"

        $result = $dialog.ShowDialog()

        if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
            foreach ($filePath in $dialog.FileNames) {
                if (Test-Path $filePath -PathType Leaf) {
                    $filesToModify += Get-Item $filePath
                }
            }

            if ($filesToModify.Count -eq 0) {
                Write-Host "No valid files selected. Returning to main menu." -ForegroundColor Red
                pause
                continue
            }

            Write-Host "`nSelected files:" -ForegroundColor Cyan
            $filesToModify | ForEach-Object { Write-Host "$($_.FullName)" }
        }
        else {
            Write-Host "Selection cancelled. Returning to main menu." -ForegroundColor Yellow
            pause
            continue
        }

    }
    elseif ($choice -eq "A" -or $choice -eq "a") {
        $targetFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
        $scriptName = $MyInvocation.MyCommand.Name
        $scriptBaseName = [System.IO.Path]::GetFileNameWithoutExtension($scriptName)
        $batName = "$scriptBaseName.bat"

        Write-Host "Target folder detected: $targetFolder" -ForegroundColor Cyan

        $filesToModify = Get-ChildItem -Path $targetFolder -File |
            Where-Object {
                $_.Name -ne $scriptName -and $_.Name -ne $batName
            }

        if ($filesToModify.Count -eq 0) {
            Write-Host "No files to modify in the folder." -ForegroundColor Red
            pause
            continue
        }

        Write-Host "`nFiles found:" -ForegroundColor Cyan
        $filesToModify | ForEach-Object { Write-Host "$($_.FullName)" }
    }
    else {
        Write-Host "Invalid choice. Try again." -ForegroundColor Red
        pause
        continue
    }

    # Date input
    $baseDate = $null
    while (-not $baseDate) {
        $dateInput = Read-Host "Enter the date (dd/MM/yyyy) or (B)ack to go back [B]"

        if ($dateInput.ToLower() -eq "b") {
            Write-Host "Returning to main menu..." -ForegroundColor Yellow
            pause
            $backToMenu = $true
            break
        }

        try {
            $baseDate = [datetime]::ParseExact($dateInput, 'dd/MM/yyyy', $null)
        }
        catch {
            Write-Host "ERROR: invalid date. Try again or type (B)ack to go back." -ForegroundColor Red
        }
    }

    if ($backToMenu) {
        continue  # back to the outer while (A/S menu)
    }

    # Apply modification
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
            Write-Host "ERROR on $($file.FullName): $($_.Exception.Message)" -ForegroundColor Red
        }
    }

    Write-Host "`nOperation completed." -ForegroundColor Cyan
    $repeat = Read-Host "Do you want to modify other files? (Y/N)"
    if ($repeat -ne "Y" -and $repeat -ne "y") {
        $globalExit = $true
    }
}

Write-Host "Exiting script." -ForegroundColor Cyan
pause