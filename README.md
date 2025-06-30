# 📜 Automated Backup Script with AWS S3 Integration

This Bash script automates the process of creating compressed backups of a specified directory and uploads them to an AWS S3 bucket. It includes basic logging, error handling, and ensures that required tools are available before proceeding.

---

## 📁 Features

- Smart AWS CLI installer based on OS type (Ubuntu/RHEL only)
- Secure backup using `.tar.gz` compression
- Automatic upload to AWS S3
- Logging for backup events and errors
- Cron job ready
- Colored terminal output for better visibility

---

## 📂 Example Use Case

You want to back up your `/var/www` directory and store the compressed backup on Amazon S3. This script makes it easy, even installing AWS CLI if it isn’t already installed.

---

## 🛠️ Prerequisites

- Bash shell (`/bin/bash`)
- Root/sudo privileges
- AWS CLI installed (auto-installed by the script if not found)
- AWS credentials configured (`~/.aws/credentials`) via:
  ```bash
  aws configure
  ```
- An S3 bucket

---

## 📦 Usage

1. **Clone this repository**

2. **Update script variables**:
   ```bash
   SOURCE_DIR="/var/www"              # Directory to back up.
   S3_BUCKET="s3://demo-bucket-name"    # S3 bucket to upload to.
   ```

3. **Make the script executable**:
   ```bash
   chmod +x automated_backup.sh
   ```

4. **Run the script manually**:
   ```bash
   ./automated_backup.sh
   ```

   - 📝 Side note: Running the script manually once is strongly recommended as we can verify whether it works as expected.

5. **Automate with Cron Job**:

   E.g., to run this script every Friday at 17:00:
   ```bash
   crontab -e
   ```
   Add this line:
   ```bash
   0 17 * * 5 /path/to/automated_backup.sh >> /var/log/backup_cron_output.log 2>&1
   ```
 
---

## 🧪 What This Script Does

1. Checks and install AWS CLI (Debian or RHEL based)
2. Ensures the source directory exists
3. Creates a `.tar.gz` backup with a timestamp
4. Uploads it to a defined S3 bucket
5. Logs each step and deletes the local backup after successful upload

---

## 📄 Log Files

Each run of the script generates a log file:
```bash
/var/log/backup_YYYY-MM-DD_HH:MM:SS.log
```

---

## ✅ Sample Output
```bash
✅ Backup created: /tmp/www_backup_2025-06-29_00:00:00.tar.gz
✅ Backup uploaded to S3 successfully.
```

---

## 🛡️ Security Tips

- 🔒 Ensure AWS credentials are stored securely in `~/.aws/credentials`.
- 🚫 Set S3 bucket permissions to **private**.

---

## 🛠️ Troubleshooting

- **AWS CLI not installed?** The script will try to install it automatically using `apt` or `yum` depending on your OS.
- **Permission denied?** Run the script as root using `sudo`.
- **Backup upload failed?** Check your AWS credentials (`~/.aws/credentials`) or IAM permissions.

---

## 🎨 Future Enhancements

- 🔐 AWS KMS encryption
- 📅 Retention policies
- 📂 Multi-directory backup
- ⚙️ Improved error handling

---

## 🤝 Contributing

Contributions are welcome! Feel free to fork the repo and submit pull requests. Open an issue for any bugs or feature requests.

---

## 📄 License

This project is licensed under the MIT License.