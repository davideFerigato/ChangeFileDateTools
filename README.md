# ChangeFileDateTools

Un semplice set di strumenti per modificare le date di creazione, modifica e accesso dei file in ambiente Windows, utilizzando script `.bat` e `.ps1`. Gli script sono ideali per uniformare le date dei file in contesti lavorativi o per esigenze documentali.

## 📦 Contenuto

- `ModificaDataSemplice.bat`: script `.bat` per semplificare l’avvio dello script PowerShell.
- `ModificaDataSemplice.ps1`: script PowerShell per modificare la data di un file (modalità base).

## 🚀 Utilizzo semplice

1. Posiziona entrambi i file `ModificaDataSemplice.bat` e `ModificaDataSemplice.ps1` nella stessa cartella dei file di cui vuoi modificare la data.
2. Esegui `ModificaDataSemplice.bat` con un doppio clic.

### ⚠️ Avvertenza importante

Non rinominare i file `ModificaDataSemplice.bat` e `ModificaDataSemplice.ps1`:  

### 🔧 Cosa fa

- Ti chiederà una data nel formato `gg/mm/aaaa`.
- Applicherà questa data a tutti i file nella cartella corrente (escludendo gli script stessi).
- L'orario sarà generato in modo casuale ma realistico, compreso tra le 08:00 e le 20:00, per simulare un contesto lavorativo.

## 🖥️ Requisiti

- Windows 10/11
- PowerShell 5.1 o superiore
- Permessi di scrittura sui file
