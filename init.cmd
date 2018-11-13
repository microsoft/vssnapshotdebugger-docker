@ECHO OFF
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0init.ps1" %*
EXIT /B %ERRORLEVEL%
