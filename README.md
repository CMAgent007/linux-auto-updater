# Linux Auto-Updater  
*A self-installing Linux system update automation script by KixxU*

> [!WARNING]
> ## ⚠️ Legal Disclaimer  
> This tool is intended for **educational use and authorized system administration only**.  
> Running automated updates on systems you do not own or manage with permission may be illegal.  
> The author is **not responsible** for any damage, data loss, or system changes caused by misuse.

## 📝 Description  
Linux Auto-Updater is a Bash-based script that keeps your Linux system automatically updated.  
It supports major distributions like **Debian, Ubuntu, Fedora, CentOS, and Arch**, and installs itself as a background cron job that runs silently based on your schedule.

## ✨ Features  
- **Interactive Setup:** Choose daily or weekly update schedules  
- **Self-Installing:** Installs into `/usr/local/bin` and configures a system-wide cron job  
- **Multi-Distro Support:** Automatically detects `apt`, `dnf`, `yum`, or `pacman`  
- **Background Operation:** Updates run silently without user interaction  
- **Clean Uninstall:** Comes with a script to remove all traces  
- **Activity Logging:** Logs all actions to `/var/log/auto_system_updates.log`

---

## 🚀 Installation & Setup

> [!INFO]
> Run the following command in your terminal to begin installation:

```bash
wget -qO- https://raw.githubusercontent.com/CMAgent007/linux-auto-updater/main/install-updater.sh | sudo bash
```

- The script will prompt you to choose daily or weekly updates and set a time.
- Once confirmed, it installs itself and schedules the task automatically.

---

## ▶️ Usage

> [!NOTE]
> After installation, the system will auto-update based on your selected schedule.  
> To check the update log:

```bash
cat /var/log/auto_system_updates.log
```

---

## ⚙️ Manual Setup (For Developers)

> [!INFO]
> Use these steps if you want to manually install or modify the script:

```bash
git clone https://github.com/CMAgent007/linux-auto-updater.git
cd linux-auto-updater
chmod +x install-updater.sh
sudo ./install-updater.sh
```

---

## 🧹 Uninstallation

> [!INFO]
> Run the following commands to fully remove the updater and its configuration:

```bash
git clone https://github.com/CMAgent007/linux-auto-updater.git
cd linux-auto-updater
chmod +x uninstall-updater.sh
sudo ./uninstall-updater.sh
```

- The script removes the cron job, the installed command, and will ask if you want to delete the log file.

---

## 👤 Author  
**KixxU**

---

## 📄 License  
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/CMAgent007/linux-auto-updater/blob/master/LICENSE)
