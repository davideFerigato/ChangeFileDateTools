@echo off
REM Avvia lo script PowerShell corrispondente ignorando restrizioni di esecuzione
powershell -ExecutionPolicy Bypass -File "%~dp0ModificaDataSemplice.ps1"

REM Pausa per permettere all’utente di leggere i risultati
pause
