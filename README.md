# ChangeFileDateTools 

Un semplice set di strumenti per modificare le date di creazione, modifica e accesso dei file in ambiente Windows, utilizzando script `.bat` e `.ps1`. Gli script sono ideali per uniformare le date dei file in contesti lavorativi o per esigenze documentali.

## 📦 Contenuto

- `ModificaDataSemplice.bat`: script `.bat` per semplificare l’avvio dello script PowerShell.
- `ModificaDataSemplice.ps1`: script PowerShell avanzato per modificare le date dei file (modalità completa con interfaccia testuale e selezione da finestra).

## 🚀 Utilizzo semplice

1. Posiziona entrambi i file `ModificaDataSemplice.bat` e `ModificaDataSemplice.ps1` nella stessa cartella dei file di cui vuoi modificare la data.
2. Esegui `ModificaDataSemplice.bat` con un doppio clic.

### ⚠️ Avvertenza importante

Non rinominare i file `ModificaDataSemplice.bat` e `ModificaDataSemplice.ps1`.  

### 🔧 Cosa fa

- All'avvio, ti chiederà se vuoi modificare la data di **tutti i file nella cartella dello script** (`T`) o **selezionarli manualmente tramite finestra di dialogo grafica** (`S`).
- In entrambi i casi, verrà mostrato l’elenco completo dei file selezionati prima di procedere.
- Successivamente ti verrà chiesta una **data da applicare** nel formato `gg/mm/aaaa`.
- Se inserisci una data non valida, potrai **riprovare o digitare `I` per tornare indietro** alla scelta iniziale.
- La data applicata include anche un **orario casuale tra le 08:00 e le 20:00**, per simulare un contesto realistico.
- Dopo l’esecuzione, potrai scegliere se **modificare altri file** o uscire.

## 🖥️ Requisiti

- Windows 10/11
- PowerShell 5.1 o superiore
- Permessi di scrittura sui file
- Interfaccia grafica abilitata (per la selezione manuale con finestra)
