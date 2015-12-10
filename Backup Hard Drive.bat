@set /p mySourceDrive="Enter Hard Drive Letter: "
@set /p myBackupDrive="Enter Backup Drive Letter: "
@call Code.bat "%mySourceDrive%:" "%myBackupDrive%:\Backup\Hard Drive" "Exclude.txt"
