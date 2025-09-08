# 📦 CPM – Custom Package Manager for Python  

A lightweight **bash script** to manage Python dependencies easily.  
CPM automates package installation, version pinning, and virtual environment setup using `pip-tools`.  

---

## ✨ Features  
- 🔧 Automatically creates and activates a **virtual environment**  
- 🛠 Ensures `pip-tools` is installed  
- ➕ Add one or multiple packages and **pin exact versions**  
- 🔄 Refresh mode: regenerate `requirements.in` and `requirements.txt` from current environment  
- 📥 Install all dependencies from `requirements.txt`  
- 🖥 Works on **Linux, macOS, and Windows** (via Git Bash or WSL)  

---

## 🚀 Installation  

Clone your repo and make the script executable:  

```bash
git clone <your-repo-url>
cd <your-repo-dir>
chmod +x cpm.sh
```

---

## 📖 Usage  

### General Syntax
```bash
./cpm.sh <package1> [package2] ...
./cpm.sh --refresh
./cpm.sh --install
```

### 🐧 Linux & 🍎 macOS  

#### Add a new package  
```bash
./cpm.sh requests
```

#### Add multiple packages  
```bash
./cpm.sh django psycopg2
```

#### Refresh `requirements.in` and rebuild `requirements.txt`  
```bash
./cpm.sh --refresh
```

#### Install from `requirements.txt`  
```bash
./cpm.sh --install
```

---

### 🪟 Windows  

#### Option 1: **Git Bash / WSL**  
Run commands just like Linux/macOS:  
```bash
./cpm.sh requests
./cpm.sh --refresh
./cpm.sh --install
```

#### Option 2: **PowerShell** (needs slight tweak)  
In PowerShell, run with `bash` if you have Git Bash installed:  
```powershell
bash cpm.sh requests
bash cpm.sh --refresh
bash cpm.sh --install
```

---

## 📂 Files Generated  

- `venv/` → Python virtual environment  
- `requirements.in` → Human-managed dependencies (unpinned)  
- `requirements.txt` → Auto-generated pinned dependencies (exact versions)  

---

## 📝 Example Workflow  

```bash
# Add dependencies
./cpm.sh fastapi uvicorn

# Refresh requirements
./cpm.sh --refresh

# Install dependencies later (e.g., on another machine)
./cpm.sh --install
```

---

## ⚠️ Notes  

- Always run CPM **inside your project folder**.  
- If you switch between shells on Windows, prefer **Git Bash** or **WSL** for best compatibility.  
- If you see `permission denied`, ensure the script is executable:  
  ```bash
  chmod +x cpm.sh
  ```
