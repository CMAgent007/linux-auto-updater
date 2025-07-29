# Linux Auto-Updater  
A self-installing Linux system update automation script by KixxU

---

### ⚠️ Legal Disclaimer  
This tool is intended for educational purposes and for use in authorized system administration or personal use cases ONLY. Automating updates on systems you do not own or have permission to manage may be illegal. The author is not responsible for any misuse, errors, or system changes caused by this tool.

---

### 📘 Description  
Linux Auto-Updater is a Bash script designed to simplify system package management across major Linux distributions. With a one-time interactive setup, it installs itself as a persistent background job and ensures your system stays up-to-date — without further manual intervention.

---

### ✨ Features  
- **Interactive Setup**: Prompts you to choose a daily or weekly update schedule  
- **One-Time Install**: Installs as a system-wide command and configures a cron job  
- **Multi-Distro Support**: Detects and uses the correct package manager (`apt`, `dnf`, `yum`, or `pacman`)  
- **Background Operation**: Runs silently on your schedule without user input  
- **Comprehensive Logging**: Logs all activity to `/var/log/auto_system_updates.log`  

---

### 🛠 Installation & Setup  
Run the following command in your terminal to begin the interactive installation:
```bash
wget -qO- https://raw.githubusercontent.com/CMAgent007/linux-auto-updater/main/install-updater.sh | sudo bash
```

---

### ▶️ Usage  

After running the installation command:

1. **Answer the Prompts**: You'll be asked to choose between daily or weekly updates, and to set the hour and minute.
2. **Confirm**: Once confirmed, the script installs and schedules itself.
3. **That's it** — your system updates are now fully automated.

To monitor the script's activity:
```bash
cat /var/log/auto_system_updates.log
```

---

### ⚙️ Manual Setup (For Developers)  
If you prefer to install manually or customize the script:

Clone the repository:
```bash
git clone https://github.com/CMAgent007/linux-auto-updater.git
cd linux-auto-updater
```

Make the script executable:
```bash
chmod +x install-updater.sh
```

Run with elevated privileges:
```bash
sudo ./install-updater.sh
```

---

### 👤 Author  
**KixxU**

---

### 📄 License  
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/CMAgent007/linux-auto-updater/blob/master/LICENSE)

