@set /p myBackupDrive="Enter Backup Drive Letter: "
@if exist "C:\Documents and Settings" @call Code.bat "C:\Documents and Settings" "%myBackupDrive%:\Backup\Documents and Settings"
@if exist "C:\Users" @call Code.bat "C:\Users" "%myBackupDrive%:\Backup\Users"
