@echo off
for /F %%a in ('dir /s /b *.vcxproj') do (
	if exist %%~pda\EDK2 rd /s /q %%~pda\EDK2
	if exist %%~pda\x64 rd /s /q %%~pda\x64
)
if exist x64\Release rd /s /q x64