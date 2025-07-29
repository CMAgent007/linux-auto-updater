Linux Auto-Updater Script

A self-installing script that automates system package updates for Debian, Ubuntu, Fedora, CentOS, Arch, and other related Linux distributions.

Description

This script is designed for a "one-and-done" setup. You run it a single time, and it interactively prompts you to define an update schedule (daily or weekly). It then installs itself as a system-wide command and automatically configures a cron job to handle all future package updates without any further user interaction.

Features

Interactive Setup: Asks for your preferred schedule upon first run.

One-Time Install: Copies itself to /usr/local/bin and configures a system cron job.

Multi-Distro Support: Automatically detects and uses the correct package manager (apt, dnf, yum, or pacman).

Background Operation: Runs silently in the background according to your schedule.

Comprehensive Logging: All update operations are logged to /var/log/auto_system_updates.log.

Installation

Run the following command in your terminal. It will download the script and start the interactive setup process.

wget -qO- [https://raw.githubusercontent.com/CMAgent007/linux-auto-updater/main/install-updater.sh](https://raw.githubusercontent.com/CMAgent007/linux-auto-updater/main/install-updater.sh) | sudo bash


Usage

After running the installation command, the script will guide you through the setup:

Answer the Prompts: The script will ask if you want updates daily or weekly, at what hour, and at what minute.

Confirm: Once you confirm the settings, the installation is complete.

The script is now fully automated. You can check on its activity at any time by viewing the log file:

cat /var/log/auto_system_updates.log


Manual Setup (for Developers)

If you want to install the script manually or modify it:

Clone the repository:

git clone [https://github.com/CMAgent007/linux-auto-updater.git](https://github.com/CMAgent007/linux-auto-updater.git)
cd linux-auto-updater


Make the script executable:

chmod +x install-updater.sh


Run it with sudo:

sudo ./install-updater.sh


Credits

Author: KixxU

License

This project is licensed under the MIT License.
