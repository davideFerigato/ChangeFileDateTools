# ChangeFileDateTools 

Un semplice set di strumenti per modificare le date di creazione, modifica e accesso dei file in ambiente Windows, utilizzando script `.bat` e `.ps1`. Gli script sono ideali per uniformare le date dei file in contesti lavorativi o per esigenze documentali.

## 📦 Contenuto

- `ModificaDataSemplice.bat`: script `.bat` per semplificare l’avvio dello script PowerShell.
- `ModificaDataSemplice.ps1`: script PowerShell per modificare la data dei file (modalità base o selettiva).

## 🚀 Utilizzo semplice

1. Posiziona entrambi i file `ModificaDataSemplice.bat` e `ModificaDataSemplice.ps1` nella stessa cartella dei file di cui vuoi modificare la data.
2. Esegui `ModificaDataSemplice.bat` con un doppio clic.

### ⚠️ Avvertenza importante

Non rinominare i file `ModificaDataSemplice.bat` e `ModificaDataSemplice.ps1`:  

### 🔧 Cosa fa

- All'avvio, ti chiederà se vuoi modificare la data di **tutti i file** nella cartella (`T`) o **selezionarli manualmente** (`S`).
- In modalità `S`, potrai inserire interattivamente i nomi dei file da processare (uno per riga), fino a scrivere `stop`.
- Ti chiederà una data nel formato `gg/mm/aaaa`.
- Applicherà questa data a ciascun file selezionato (escludendo gli script stessi).
- L'orario sarà generato in modo casuale ma realistico, compreso tra le 08:00 e le 20:00, per simulare un contesto lavorativo.

## 🖥️ Requisiti

- Windows 10/11
- PowerShell 5.1 o superiore
- Permessi di scrittura sui file
