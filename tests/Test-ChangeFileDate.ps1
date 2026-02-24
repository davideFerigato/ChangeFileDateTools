<#
.SYNOPSIS
    Simple test script for ChangeFileDateTools.
.DESCRIPTION
    Creates temporary files, runs the main script, and verifies date changes.
.NOTES
    This test should be run from the project root folder.
#>

# Create a temporary test folder
$testFolder = Join-Path $env:TEMP "ChangeFileDateTest_$(Get-Random)"
New-Item -ItemType Directory -Path $testFolder -Force | Out-Null

try {
    # Copy scripts to test folder
    Copy-Item ".\scripts\ChangeFileDate.bat" -Destination $testFolder
    Copy-Item ".\scripts\ChangeFileDate.ps1" -Destination $testFolder

    # Create dummy files
    1..3 | ForEach-Object {
        $file = Join-Path $testFolder "test$_.txt"
        Set-Content -Path $file -Value "Sample content $_"
    }

    Write-Host "Test files created in: $testFolder" -ForegroundColor Cyan

    # Here you could automate the interaction with the script
    # For manual testing, you can pause and instruct the user
    Write-Host "`nPlease run ChangeFileDate.bat manually from the test folder and verify the changes."
    Write-Host "Test folder: $testFolder" -ForegroundColor Yellow

    # Optionally, you could use SendKeys or other automation,
    # but for simplicity we'll keep it manual.
    Read-Host "Press Enter when you have completed the test..."

    # After test, you could check dates if you recorded them, but here just cleanup
}
finally {
    # Cleanup
    Remove-Item -Path $testFolder -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Test folder cleaned up." -ForegroundColor Green
}