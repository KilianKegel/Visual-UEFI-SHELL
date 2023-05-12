@echo off
set BUILDSTART=%time% %date%
call build.bat -t VS2015
set BUILDEND=%time% %date%
echo started: %BUILDSTART%
echo   ended: %BUILDEND%