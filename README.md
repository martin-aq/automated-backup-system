# 🗄️ Automated Backup System with Bash and AWS S3

This project automates directory backups using a Bash script. It compresses the data and uploads it to an AWS S3 bucket. The system includes basic error handling and logging.

---

## 🚀 Features

- 🕰️ Scheduled backups with Cron
- 📦 Compressed archive (`.tar.gz`)
- ☁️ Automatic upload to AWS S3
- 📝 Backup logging

---

## 🛠️ Prerequisites

1. **Install AWS CLI**  
   ```bash
   sudo apt update
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   unzip awscliv2.zip
   sudo ./aws/install
   ```

2. **Configure AWS CLI**  
   ```bash
   aws configure
   ```
   Enter:
   - AWS Access Key ID  
   - AWS Secret Access Key  
   - Default region  
   - Output format (`json`, `table`, or `text`)

3. **Create an S3 Bucket**  
   - Go to the AWS S3 console.  
   - Create a private bucket (example: `my-backup-demo-bucket`).

---

## 📜 Setup

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/yourusername/automated-backup-system.git
   cd automated-backup-system
   ```

2. **Edit Configuration in `automated_backup.sh`:**
   ```bash
   # Configuration
   BACKUP_SRC="/path/to/your/directory"
   S3_BUCKET="s3://your-s3-bucket-name"
   BACKUP_DEST="/tmp"
   LOG_FILE="/var/log/backup.log"
   ```

3. **Make Script Executable:**
   ```bash
   chmod +x automated_backup.sh
   ```
   
4. **Commit Initial Configuration:**
   After editing the backup script, commit your changes:
   ```bash
   git add automated_backup.sh
   git commit -m "Initial backup configuration"
   git push origin main
   ```

---

## 🚀 Usage

1. **Run Manually:**
   ```bash
   ./automated_backup.sh
   ```

2. **Automate with Cron (every Friday at 5PM):**
   ```bash
   crontab -e
   ```
   Add this line:
   ```
   0 17 * * 5 /path/to/automated_backup.sh
   ```

---

## 📝 Example Log Output

Example entry in `/var/log/automated_backup.log`:

```
[2025-02-24 02:00:01] Starting backup of /path/to/your/directory
[2025-02-24 02:00:10] ✅ Backup completed and uploaded to S3 successfully!
```
---

## 💻 Monitoring and Logs

- **Check logs for backup status:**
```
tail -f /var/log/backup.log
```

---

## 🛡️ Security Tips

- 🔒 Ensure AWS credentials are stored securely in `~/.aws/credentials`.
- 🚫 Set S3 bucket permissions to **private**.
- 🕰️ Enable versioning or lifecycle policies for retention.

---

## 🎨 Future Enhancements

- 🔑 AWS KMS encryption
- 📅 Retention policies
- 📂 Multi-directory backup
- ⚙️ Improved error handling

---

## 🤝 Contributing

Contributions are welcome! Feel free to fork the repo and submit pull requests. Open an issue for any bugs or feature requests.

---

## 📄 License

This project is licensed under the MIT License.

---

💡 *Built with Bash and AWS S3 for simplified backup automation.*
