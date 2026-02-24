@echo off
REM Launches the corresponding PowerShell script bypassing execution restrictions
powershell -ExecutionPolicy Bypass -File "%~dp0ChangeFileDate.ps1"

REM Pause to allow the user to read the results
pause