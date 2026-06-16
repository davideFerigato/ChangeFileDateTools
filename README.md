# ChangeFileDateTools 🕒

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue)](https://github.com/PowerShell/PowerShell)
[![Windows](https://img.shields.io/badge/Platform-Windows-0078d7.svg)](https://www.microsoft.com/windows)
[![GitHub release](https://img.shields.io/github/v/release/davideFerigato/ChangeFileDateTools)](https://github.com/davideFerigato/ChangeFileDateTools/releases)
[![Tests](https://github.com/davideFerigato/ChangeFileDateTools/actions/workflows/tests.yml/badge.svg)](https://github.com/davideFerigato/ChangeFileDateTools/actions/workflows/tests.yml)
![GitHub last commit](https://img.shields.io/github/last-commit/davideFerigato/ChangeFileDateTools)

**ChangeFileDateTools** is a lightweight set of tools for Windows that allows you to easily and quickly modify the creation, modification, and access dates of files. Ideal for standardizing timestamps in work environments, organizing document archives, or simulating realistic time scenarios.

---

## 📋 Table of Contents

- [Key Features](#-key-features)
- [Package Contents](#-package-contents)
- [System Requirements](#-system-requirements)
- [Installation & Quick Start](#-installation--quick-start)
- [Usage Guide](#-usage-guide)
- [Practical Example](#-practical-example)
- [Important Notes](#-important-notes)
- [Technologies Used](#-technologies-used)

---

## ✨ Key Features

- ✅ **Dual selection mode**: modify all files in the folder or select them individually via a graphical dialog.
- ✅ **Visual preview**: see the list of selected files before applying changes.
- ✅ **Custom date**: enter the desired date in `dd/MM/yyyy` format.
- ✅ **Realistic random time**: automatically assigns a random time between 08:00 and 20:00 to simulate working hours.
- ✅ **Smart error handling**: invalid date? You can retry or return to the main menu.
- ✅ **Continuous cycle**: modify multiple groups of files in sequence without restarting the script.

---

## 📦 Package Contents

| File | Description |
|------|-------------|
| `ChangeFileDate.bat` | Batch launcher: opens PowerShell and runs the main script. |
| `ChangeFileDate.ps1` | Full PowerShell script with text-based interface and graphical file selection. |

---

## 💻 System Requirements

- **Operating System**: Windows 10, Windows 11 (or equivalent server versions)
- **PowerShell**: version 5.1 or higher (pre-installed on modern Windows)
- **Permissions**: read/write access to the files you want to modify
- **Graphical interface**: required only for manual selection mode (`S`)

---

## 🚀 Installation & Quick Start

1. **Download** the latest version from the [Releases page](https://github.com/your-username/ChangeFileDateTools/releases) or clone the repository:
   ```bash
   git clone https://github.com/your-username/ChangeFileDateTools.git
   ```
2. **Place** both files (`ChangeFileDate.bat` and `ChangeFileDate.ps1`) into the folder containing the files you want to modify.
3. **Run** `ChangeFileDate.bat` by double-clicking it.

> 💡 **Tip**: You can create a desktop shortcut to the `.bat` file for even quicker access.

---

## 🧭 Usage Guide

When you start the script, you will be presented with the following options:

1. **A** → Modify the date of **all** files in the script's folder.
2. **S** → Open a dialog window to **manually select** files (supports multi‑select with `Ctrl`).

After selection, the script displays the full list of chosen files and asks for confirmation.

Then:
- Enter the **date** in `dd/MM/yyyy` format (e.g., `15/03/2025`).
- If the date is valid, the script applies to each file:
  - 📅 **Creation date** = specified date + random time
  - 📅 **Modification date** = specified date + random time
  - 📅 **Access date** = specified date + random time

If the date is invalid:
- Press `R` to try again.
- Press `B` to go back to the initial choice (file selection).

When finished, you will be asked if you want to modify more files:
- `Y` → repeat the process
- `N` → exit the script

---

## 🎯 Practical Example

Imagine you have a folder `Documents/Work/Reports` with dozens of PDF and DOCX files generated on different dates. You want to standardize them all to **01/02/2025** to present them as a single coherent batch.

1. Copy the two scripts into the `Reports` folder.
2. Run `ChangeFileDate.bat`.
3. Choose `A` (all files).
4. Confirm the displayed list.
5. Enter `01/02/2025`.
6. The script applies the date with random times (e.g., 09:15, 14:30, 18:45).
7. Confirmation message: *"Dates successfully modified for 15 files."*

---

## ⚠️ Important Notes

- 🔒 **Do not rename** `ChangeFileDate.bat` and `ChangeFileDate.ps1`: the script relies on these exact names.
- 🔄 **The operation is irreversible**: once changed, the original dates are overwritten. We recommend backing up your files first.
- 🛡️ **Use with caution**: only modify dates if you are sure of the implications (e.g., legal documents, audits, archives).
- 📂 **Long paths**: if file paths exceed 260 characters, Windows may have limitations; ensure files are in accessible locations.

---

## 🛠️ Technologies Used

- **Batch script** (`.bat`) – for simple launching and compatibility with the classic Windows interface.
- **PowerShell** (`.ps1`) – for advanced logic, date handling, graphical dialogs, and file manipulation.
- **.NET Framework** – used by PowerShell for graphical components (`System.Windows.Forms`).

---

## 🧪 Future Improvements (Ideas)

- Add support for fully customisable date and time.
- Implement logging of operations to a text file.
- Create a full graphical version (WPF or Windows Forms).
- Add recursive modification in subfolders.
