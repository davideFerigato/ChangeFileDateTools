# Detailed Usage Guide for ChangeFileDateTools

This guide provides in‑depth instructions on how to use ChangeFileDateTools to modify file dates in various scenarios.

## Table of Contents
- [Selection Modes](#selection-modes)
- [Date Format](#date-format)
- [Error Handling](#error-handling)
- [Advanced Examples](#advanced-examples)
- [Frequently Asked Questions](#frequently-asked-questions)
- [Troubleshooting](#troubleshooting)

---

## Selection Modes

### Mode A (All files)
When you choose option **A**, the script automatically scans the folder it resides in and selects **all files**, excluding only itself (`ChangeFileDate.ps1`) and the batch launcher (`ChangeFileDate.bat`).

**Useful when:**
- You want to standardise the dates of an entire archive.
- You have dozens or hundreds of files to modify.
- You don't want to select each file manually.

### Mode S (Select manually)
Option **S** opens a standard Windows file dialog that allows you to select one or more files (hold `Ctrl` for multi‑select).

**Useful when:**
- You need to modify only specific files in a folder.
- You want to select files from different folders (you can navigate in the dialog).
- You have only a few files to modify.

**Note:** Manual selection requires the Windows graphical interface to be enabled (it always is in standard installations).

---

## Date Format

The script expects the date in **dd/MM/yyyy** format (day/month/year).

**Valid examples:**
- `15/03/2025` → 15 March 2025
- `01/01/2024` → 1 January 2024
- `31/12/2023` → 31 December 2023

**Invalid examples:**
- `2025-03-15` (ISO format not supported)
- `15-03-2025` (hyphens instead of slashes)
- `32/01/2025` (non‑existent day)
- `15/13/2025` (non‑existent month)

If you enter an invalid date, the script shows an error and prompts you again. You can either try a new date or type **B** to go back to the initial (A/S) menu.

---

## Advanced Examples

### Scenario 1: Project archive
You have a folder `C:\Projects\ClientX` with 150 files (documents, spreadsheets, presentations) created between 2020 and 2024. You want to simulate that they were all generated on 1 June 2025.

1. Copy both scripts into `C:\Projects\ClientX`.
2. Run `ChangeFileDate.bat`.
3. Choose **A** (All files).
4. Review the list (it will be displayed on screen).
5. Enter `01/06/2025`.
6. The script assigns the date with a random time to each file (e.g., 08:23, 14:47, 19:12).

### Scenario 2: Targeted selection
You need to modify only the PDF files in the `Documents` folder, excluding Word files and images.

1. Copy the scripts into `Documents`.
2. Run `ChangeFileDate.bat`.
3. Choose **S** (Select manually).
4. In the dialog, select only the desired PDF files (use `Ctrl` for multiple).
5. Confirm the selection.
6. Enter the desired date.
7. Only the selected PDFs will be modified.

### Scenario 3: Multiple modification cycles
After modifying one group of files, you can answer **Y** (Yes) when asked "Do you want to modify other files?" to repeat the operation with a different date or on different files, without restarting the script.

---

## Frequently Asked Questions

**Q: Can I modify files in subfolders?**  
A: Not yet – currently the script only works on files directly inside the folder where it is placed. Recursive modification is planned for a future release.

**Q: Does the script work on Windows 7?**  
A: It should work on Windows 7 with PowerShell 5.1 installed, but it has only been tested on Windows 10 and 11.

**Q: What happens if I rename the script files?**  
A: The scripts rely on their own names to exclude themselves from the "All files" selection. If you rename them, they might be included in the modification, which is not recommended.

**Q: Can I set a specific time instead of a random one?**  
A: Currently the time is always random between 08:00 and 20:00. Full customisation is on the roadmap.

---

## Troubleshooting

### "No files to modify in the folder"
- Make sure there are files other than the scripts themselves.
- Check that you have read permissions for the folder.

### "ERROR on file: Access to the path is denied"
- The file might be open in another program.
- You may not have write permissions. Try running the script as Administrator.

### The graphical file dialog does not open
- Ensure that Windows Forms is available (it is by default on all Windows systems).
- If you are running a minimal/server installation, the graphical subsystem might be missing.

### The date seems incorrect after modification
- Double‑check that you entered the date in **dd/MM/yyyy** format.
- Remember that the script adds a random time; you can check the full timestamp in the file properties (including time).

For further help, please [open an issue](https://github.com/davideFerigato/ChangeFileDateTools/issues) on GitHub.
