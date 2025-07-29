Linux Auto-Updater  
A self-installing Linux system update automation script by KixxU

------------------------------------------------------------

⚠️ Legal Disclaimer  
This tool is intended for educational use and personal system maintenance only.  
Automating updates on machines you do not own or manage with proper authorization may be illegal.  
The author holds no responsibility for any issues, data loss, or system malfunctions caused by misuse.

------------------------------------------------------------

📘 Description  
Linux Auto-Updater is a portable Bash script that automates system package updates  
across major Linux distributions (Debian, Ubuntu, Fedora, CentOS, Arch, etc.).  
It installs itself with a one-time setup and uses cron to silently update the system  
based on your preferred schedule.

------------------------------------------------------------

✨ Features  
- Interactive Setup: Choose daily or weekly update schedule  
- Self-Installing: Adds itself to /usr/local/bin and creates a cron job  
- Multi-Distro Support: Automatically detects apt, dnf, yum, or pacman  
- Silent Background Operation: No user input required after setup  
- Clean Uninstall: Comes with a script to remove itself safely  
- Logging: Logs all actions to /var/log/auto_system_updates.log

------------------------------------------------------------

🛠 Installation & Setup  
Run this command in your terminal to start interactive setup:

wget -qO- https://raw.githubusercontent.com/CMAgent007/linux-auto-updater/main/install-updater.sh | sudo bash

You'll be asked to choose your schedule and time. The script then installs and configures itself.

------------------------------------------------------------

▶️ Usage  
1. Answer the prompts (daily/weekly, time of day)  
2. Confirm setup  
3. Done — system will update automatically as scheduled

To check the updater’s activity log:

cat /var/log/auto_system_updates.log

------------------------------------------------------------

⚙️ Manual Setup (For Developers)  
If you'd prefer to install manually or make modifications:

1. Clone the repository:

   git clone https://github.com/CMAgent007/linux-auto-updater.git  
   cd linux-auto-updater

2. Make the installer executable:

   chmod +x install-updater.sh

3. Run the installer manually with elevated privileges:

   sudo ./install-updater.sh

This gives you control over the script before deployment.

------------------------------------------------------------

🧹 Uninstallation  
To completely remove the updater:

1. Clone or navigate to the directory:
   git clone https://github.com/CMAgent007/linux-auto-updater.git  
   cd linux-auto-updater

2. Make the uninstaller executable:
   chmod +x uninstall-updater.sh

3. Run the uninstaller:
   sudo ./uninstall-updater.sh

It will remove the script, the cron job, and optionally delete the log file.

------------------------------------------------------------

👤 Author: KixxU  
📄 License:  
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/CMAgent007/linux-auto-updater/blob/master/LICENSE)
