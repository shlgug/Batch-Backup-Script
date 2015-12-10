# Batch-Backup-Script
A Windows batch script for backing up files from one location to another

-------------
Version 1.2.0
-------------

What it does:

- Checks if any files were deleted from the source and deletes them from the backup.
- Copies new and changed files from the source to the backup

Notes:

- "Backup Hard Drive.bat" asks for the drive letters of the drives to backup from & to.
It then runs the backup code to backup all files from the 'backup from' hard drive
to "\Backup\Hard Drive" on the backup drive.
- "Backup All Users.bat" asks for the drive letter of the drive to backup to.
It then runs the backup code to backup from "C:\Documents and Settings" and/or "C:\Users"
to "\Backup\Documents and Settings" and/or "\Backup\Users" on the backup drive.
- To change the location, right-click the file and click edit to edit it manually.
You may want to make a copy of the file before changing the location.
- "Code.bat" is the backup code that is run with the parameters provided by the above mentioned batch files.
"Code.bat" takes the following parameters: Code.bat Source Destination [ExcludeFile]
Source is the location to backup.
Destination is the location to backup to.
ExlcudeFile (optional) is the location of the text file which lists items to exclude from the backup (see below).
- The exclude file (which by default is called only by the "Backup Hard Drive.bat" file) should contain a list of strings
to exclude, each on a separate line.  When any of the strings match any part of the absolute path of the file to
be copied, that file will be excluded from being copied.  For example, specifying a string like \obj\ or .obj will
exclude all files underneath the directory obj or all files with the .obj extension respectively.
