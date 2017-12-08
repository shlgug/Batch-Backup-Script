@verify on
@if "%~1"=="/?" (
	@echo Source, Destination, Exclude File Path
	@pause
	@goto :eof
)
@if not exist "%~1" (
	@echo Invalid Source!
	@pause
	@goto :eof
)
@if not exist "%~2" @set /p myMakeFolder="Destination does not exist, try to create it (y/n)? "
@if /i "%myMakeFolder%"=="y" @md "%~2"
@if not exist "%~2" (
	@echo Invalid Destination!
	@pause
	@goto :eof
)
@echo %~2>tempDestinationPath.txt
@for /f "tokens=1,2,3,4,5,6,7,8,9,10,11,12 delims=\" %%a in (tempDestinationPath.txt) do @(
	@if not "%%l"=="" (
		@echo Destination Path Is Too Deep!
		@pause
		@goto :eof
	) else (
		@set myNumber=12
		@if "%%k"=="" (
			@set myNumber=11
			@if "%%j"=="" (
				@set myNumber=10
				@if "%%i"=="" (
					@set myNumber=9
					@if "%%h"=="" (
						@set myNumber=8
						@if "%%g"=="" (
							@set myNumber=7
							@if "%%f"=="" (
								@set myNumber=6
								@if "%%e"=="" (
									@set myNumber=5
									@if "%%d"=="" (
										@set myNumber=4
										@if "%%c"=="" (
											@set myNumber=3
											@if "%%b"=="" (
												@set myNumber=2
											)
										)
									)
								)
							)
						)
					)
				)
			)
		)
	)
)
@del/f/q tempDestinationPath.txt
@set mySourcePath=%~1
@if not "%mySourcePath:~-1%"=="\" (
	@echo a=\>mySourceSeparator.txt
) else (
	@echo a=>mySourceSeparator.txt
)
@set myDestinationPath=%~2
@if not "%myDestinationPath:~-1%"=="\" (
	@echo a=\>myDestinationSeparator.txt
) else (
	@echo a=>myDestinationSeparator.txt
)
@echo --------------------------------------
@echo Starting Backup...
@echo Backing Up From "%~1" To "%~2"
@echo --------------------------------------
@title Building Lists...
@echo Building Lists...
@dir/b/s/a:-d "%~2\*.*">tempBackupFiles.txt
@echo Done Building Files List!
@dir/b/s/a:d "%~2\*.*">tempBackupFolders.txt
@echo Done Building Folders List!
@echo --------------------------------------
@echo Deleting Files ^& Folders That No Longer Exist...
@for /f "tokens=1,2 delims==" %%a in (mySourceSeparator.txt) do @(
	@for /f "tokens=1,2 delims==" %%c in (myDestinationSeparator.txt) do @(
		@for /f "tokens=%myNumber%* delims=\" %%i in (tempBackupFiles.txt) do @(
			@if "%%j"=="" (
				@title Checking: \%%i
				@if not exist "%~1%%b%%i" (
					@echo --- Deleting: "%~2%%d%%i"
					@del/f/q "%~2%%d%%i"
				)

			) else (
				@title Checking: \%%i\%%j
				@if not exist "%~1%%b%%i\%%j" (
					@echo --- Deleting: "%~2%%d%%i\%%j"
					@del/f/q "%~2%%d%%i\%%j"
				)
			)
		)
	)
)
@echo Done Deleting Old Files!
@for /f "tokens=1,2 delims==" %%a in (mySourceSeparator.txt) do @(
	@for /f "tokens=1,2 delims==" %%c in (myDestinationSeparator.txt) do @(
		@for /f "tokens=%myNumber%* delims=\" %%i in (tempBackupFolders.txt) do @(
			@if "%%j"=="" (
				@title Checking: \%%i
				@if not exist "%~1%%b%%i" (
					@echo --- Deleting: "%~2%%d%%i"
					@rd/s/q "%~2%%d%%i"
				)

			) else (
				@title Checking: \%%i\%%j
				@if not exist "%~1%%b%%i\%%j" (
					@echo --- Deleting: "%~2%%d%%i\%%j"
					@rd/s/q "%~2%%d%%i\%%j"
				)
			)
		)
	)
)
@echo Done Deleting Old Folders!
@del/f/q mySourceSeparator.txt
@del/f/q myDestinationSeparator.txt
@del/f/q tempBackupFiles.txt
@del/f/q tempBackupFolders.txt
@title Copying New ^& Changed Files ^& Folders...
@echo --------------------------------------
@echo Copying New ^& Changed Files ^& Folders...
@if "%~3"=="" (
	@xcopy /h/k/e/d/c/y "%~1\*.*" "%~2\"
) else (
	@xcopy /h/k/e/d/c/y/exclude:%~3 "%~1\*.*" "%~2\"
)
@echo Done Copying New Files ^& Folders!
@echo Backup Last Completed On %Date% At %Time%>"%~2\LastBackup.txt"
@title Backup Complete!
@echo --------------------------------------
@echo Backup Complete!
@echo --------------------------------------
@pause
