#!/bin/bash

# Define full paths to commands to avoid issues with Cron Jobs
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Function to define color variables
function set_colors {
    RED='\033[31m'
    GREEN='\033[32m'
    YELLOW='\033[33m'
    NC='\033[0m'
}

# Call the function to initialize colors
set_colors

# Variables
SOURCE_DIR="/var/www"  # Change to the directory you want to back up. This is just an example.
BACKUP_DIR="/tmp"
TIMESTAMP=$(date +'%Y-%m-%d_%H:%M:%S')
S3_BUCKET="s3://demo-bucket-name" # Create your S3 bucket. This is just an example.
BASENAME=$(basename "$SOURCE_DIR")
BACKUP_DEST="${BACKUP_DIR}/${BASENAME}_backup_${TIMESTAMP}.tar.gz"
LOG_FILE="/var/log/backup_${TIMESTAMP}.log"

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo -e "⚠ ${YELLOW}AWS CLI is not installed. Installing it...${NC}" | tee -a "$LOG_FILE"
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "$ID" == "debian" || "$ID_LIKE" == *debian* ]]; then
            apt update && apt install awscli -y
            echo -e "✅ ${GREEN}Successfully installed AWS CLI.${NC}" | tee -a "$LOG_FILE"
        elif [[ "$ID" == "rhel" || "$ID" == "fedora" || "$ID_LIKE" == *rhel* || "$ID_LIKE" == *fedora* ]]; then
            yum install awscli -y
            echo -e "✅ ${GREEN}Successfully installed AWS CLI.${NC}" | tee -a "$LOG_FILE"
        else
            echo -e "❌ ${RED}Unsupported OS. Please install AWS CLI manually.${NC}" | tee -a "$LOG_FILE"
            exit 1
        fi
    else
        echo -e "❌ ${RED}AWS CLI installation failed. Please install AWS CLI manually. Exiting...${NC}" | tee -a "$LOG_FILE"
        exit 1
    fi
fi

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "⚠ ${YELLOW}Directory $SOURCE_DIR does not exist. Creating it...${NC}" | tee -a "$LOG_FILE"
    mkdir -p "$SOURCE_DIR"
    if [ $? -ne 0 ]; then
        echo -e "❌ ${RED}Failed to create ${SOURCE_DIR}. Exiting.${NC}" | tee -a "$LOG_FILE"
        exit 1
    fi
fi

# Create a compressed backup
if tar -czf "$BACKUP_DEST" "$SOURCE_DIR"; then
    echo -e "✅ ${GREEN}Backup created: $BACKUP_DEST ${NC}" | tee -a "$LOG_FILE"
else
    echo -e "❌ ${RED}Failed to create backup.${NC}" | tee -a "$LOG_FILE"
    exit 1
fi

# Upload to S3
if aws s3 cp "$BACKUP_DEST" "$S3_BUCKET" >> "$LOG_FILE" 2>&1; then
    echo -e "✅ ${GREEN}Backup uploaded to S3 successfully.${NC}" | tee -a "$LOG_FILE"
    rm "$BACKUP_DEST"  # Cleanup after successful upload
else
    echo -e "❌ ${RED}Error uploading backup to S3!${NC}" | tee -a "$LOG_FILE"
    exit 1
fi