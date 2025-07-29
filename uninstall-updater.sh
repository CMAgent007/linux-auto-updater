#!/bin/bash

# #############################################################################
#
# Title: Uninstallation Script for Auto-Updater
# Description: This script safely removes the auto-system-updater script,
#              the associated cron job, and optionally the log file.
# Author: KixxU
#
# #############################################################################

# --- Configuration ---
# These paths must match the ones in the installation script.
INSTALL_PATH="/usr/local/bin/auto-system-updater"
LOG_FILE="/var/log/auto_system_updates.log"

echo "--- Automated Update Script Uninstaller ---"
echo ""

# 1. Check for root privileges
if [[ $EUID -ne 0 ]]; then
   echo "ERROR: This uninstaller must be run as root or with sudo."
   echo "Please run as: sudo ./uninstall-updater.sh"
   exit 1
fi

# 2. Remove the cron job
echo "Searching for cron job..."
# Check if the cron job exists before trying to remove it
if (crontab -l 2>/dev/null | grep -q "$INSTALL_PATH"); then
    # Use grep's -v flag to filter out the line and reinstall the crontab
    (crontab -l 2>/dev/null | grep -v "$INSTALL_PATH") | crontab -
    echo "✅ Cron job for auto-updater has been removed."
else
    echo "ℹ️  No cron job found. Nothing to do."
fi
echo ""

# 3. Delete the script file
echo "Searching for script file..."
if [ -f "$INSTALL_PATH" ]; then
    if ! rm "$INSTALL_PATH"; then
        echo "❌ ERROR: Failed to delete the script at $INSTALL_PATH."
    else
        echo "✅ Script file deleted from $INSTALL_PATH."
    fi
else
    echo "ℹ️  Script file not found. Nothing to do."
fi
echo ""

# 4. Ask to delete the log file
if [ -f "$LOG_FILE" ]; then
    read -p "Do you want to delete the log file? ($LOG_FILE) (y/n): " confirm_log_delete
    if [[ "$confirm_log_delete" == [Yy]* ]]; then
        if ! rm "$LOG_FILE"; then
            echo "❌ ERROR: Failed to delete the log file."
        else
            echo "✅ Log file deleted."
        fi
    else
        echo "ℹ️  Log file has been kept."
    fi
else
    echo "ℹ️  Log file not found."
fi
echo ""

echo "--- Uninstallation complete ---"

exit 0
