#!/bin/bash

# #############################################################################
#
# Title: Self-Installing Automated System Update Script
# Description: This script, when run once, interactively sets up a cron job
#              to automatically update system packages. It copies itself to a
#              system directory and configures the schedule based on user input.
# Author: KixxU
#
# #############################################################################

# --- Configuration ---
# The location where the script will be copied for permanent execution.
INSTALL_PATH="/usr/local/bin/auto-system-updater"
# The path for the log file.
LOG_FILE="/var/log/auto_system_updates.log"


# --- Update Functions ---

# Function to add a timestamp to log entries
log() {
    # This function will be called by the script when it runs in update mode.
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Function to update packages on Debian/Ubuntu based systems
update_apt() {
    log "Starting APT package update..."
    export DEBIAN_FRONTEND=noninteractive
    if ! apt-get update -q; then log "ERROR: apt-get update failed."; exit 1; fi
    log "Package lists updated."
    if ! apt-get upgrade -y -q; then log "ERROR: apt-get upgrade failed."; exit 1; fi
    log "System packages upgraded."
    if ! apt-get autoremove -y -q; then log "ERROR: apt-get autoremove failed."; else log "Unnecessary packages removed."; fi
    log "APT package update finished."
}

# Function to update packages on RHEL/CentOS/Fedora based systems
update_yum_dnf() {
    local PKG_MANAGER=$1
    log "Starting $PKG_MANAGER package update..."
    if ! "$PKG_MANAGER" update -y -q; then log "ERROR: $PKG_MANAGER update failed."; exit 1; fi
    log "$PKG_MANAGER package update finished."
}

# Function to update packages on Arch Linux based systems
update_pacman() {
    log "Starting Pacman package update..."
    if ! pacman -Syu --noconfirm; then log "ERROR: pacman update failed."; exit 1; fi
    log "Pacman package update finished."
}

# --- Main Execution Logic ---

# This is the main function that runs when the cron job triggers the script.
run_update_tasks() {
    # Add a separator for the new log session
    echo "=================================================" >> "$LOG_FILE"
    log "Automated update process started by cron."

    # Check for the package manager and run the corresponding update function
    if command -v apt-get &> /dev/null; then
        update_apt
    elif command -v dnf &> /dev/null; then
        update_yum_dnf "dnf"
    elif command -v yum &> /dev/null; then
        update_yum_dnf "yum"
    elif command -v pacman &> /dev/null; then
        update_pacman
    else
        log "ERROR: No supported package manager found. Exiting."
        exit 1
    fi

    log "Automated update process finished successfully."
    echo "=================================================" >> "$LOG_FILE"
    echo "" >> "$LOG_FILE"
    exit 0
}


# --- Installation Logic ---

# This is the main function that runs when the user executes the script for the first time.
run_installation() {
    echo "--- Automated Update Script Installer ---"
    echo "This script will install itself and set up a cron job for automatic updates."

    # 1. Check for root privileges
    if [[ $EUID -ne 0 ]]; then
       echo "ERROR: This installer must be run as root or with sudo."
       echo "Please run as: sudo ./your_script_name.sh"
       exit 1
    fi

    # 2. Get user preferences for the schedule
    local frequency hour minute day_of_week
    while true; do
        read -p "Run updates daily or weekly? (d/w): " frequency
        case "$frequency" in
            [Dd]* ) frequency="daily"; break;;
            [Ww]* ) frequency="weekly"; break;;
            * ) echo "Invalid input. Please enter 'd' for daily or 'w' for weekly.";;
        esac
    done

    while true; do
        read -p "What hour of the day should it run? (0-23): " hour
        if [[ "$hour" =~ ^([0-1]?[0-9]|2[0-3])$ ]]; then
            break
        else
            echo "Invalid hour. Please enter a number between 0 and 23."
        fi
    done

    while true; do
        read -p "What minute of the hour should it run? (0-59): " minute
        if [[ "$minute" =~ ^[0-5]?[0-9]$ ]]; then
            break
        else
            echo "Invalid minute. Please enter a number between 0 and 59."
        fi
    done

    if [[ "$frequency" == "weekly" ]]; then
        while true; do
            read -p "What day of the week? (0=Sun, 1=Mon, ..., 6=Sat): " day_of_week
            if [[ "$day_of_week" =~ ^[0-6]$ ]]; then
                break
            else
                echo "Invalid day. Please enter a number between 0 and 6."
            fi
        done
    fi

    # 3. Construct the cron schedule
    local cron_schedule
    if [[ "$frequency" == "daily" ]]; then
        cron_schedule="$minute $hour * * *"
    else
        cron_schedule="$minute $hour * * $day_of_week"
    fi

    echo "----------------------------------------"
    echo "Configuration Summary:"
    echo "  - Update Frequency: $frequency"
    echo "  - Run Time: $hour:$minute"
    if [[ "$frequency" == "weekly" ]]; then
        echo "  - Run Day: $day_of_week"
    fi
    echo "  - Script will be installed to: $INSTALL_PATH"
    echo "  - Log file will be at: $LOG_FILE"
    echo "----------------------------------------"
    read -p "Proceed with installation? (y/n): " confirm
    if [[ "$confirm" != [Yy]* ]]; then
        echo "Installation cancelled."
        exit 0
    fi

    # 4. Perform the installation
    echo "Installing script..."
    if ! cp "$0" "$INSTALL_PATH"; then
        echo "ERROR: Failed to copy script to $INSTALL_PATH."
        exit 1
    fi
    echo "Script copied to $INSTALL_PATH"

    if ! chmod +x "$INSTALL_PATH"; then
        echo "ERROR: Failed to make script executable."
        exit 1
    fi
    echo "Set execute permissions on script."

    if ! touch "$LOG_FILE"; then
        echo "ERROR: Failed to create log file."
        exit 1
    fi
    chmod 664 "$LOG_FILE"
    echo "Log file created at $LOG_FILE"

    # 5. Create the cron job
    # We use a unique comment to avoid adding duplicate jobs on re-run
    local cron_job_line="$cron_schedule $INSTALL_PATH --update"
    (crontab -l 2>/dev/null | grep -v "$INSTALL_PATH"; echo "$cron_job_line #Auto-updater job") | crontab -
    
    echo ""
    echo "✅ Success! The auto-update script has been installed."
    echo "It will run automatically based on the schedule you provided."
    echo "You can check the logs at any time by running: cat $LOG_FILE"
    exit 0
}


# --- Script Entry Point ---
# Check if the script is called with the --update flag.
# If yes, it's a cron job run. Run the update tasks.
# If no, it's a manual run. Start the installation process.
if [[ "$1" == "--update" ]]; then
    run_update_tasks
else
    run_installation
fi
