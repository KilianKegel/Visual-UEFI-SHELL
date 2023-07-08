@echo off
set BUILDSTART=%time% %date%
if exist EDK2\Build\Shell\RELEASE_VS2015\X64\ShellPkg\Application\Shell\EA4BB293-2D7F-4456-A681-1F22F42CD0BC\OUTPUT\Shell.efi del EDK2\Build\Shell\RELEASE_VS2015\X64\ShellPkg\Application\Shell\EA4BB293-2D7F-4456-A681-1F22F42CD0BC\OUTPUT\Shell.efi
call build.bat -t VS2015
set BUILDEND=%time% %date%
echo started: %BUILDSTART%
echo   ended: %BUILDEND%

if exist EDK2\Build\Shell\RELEASE_VS2015\X64\ShellPkg\Application\Shell\EA4BB293-2D7F-4456-A681-1F22F42CD0BC\OUTPUT\Shell.efi (
    echo.
    echo CREATED SUCCESSFULLY: EDK2\Build\Shell\RELEASE_VS2015\X64\ShellPkg\Application\Shell\EA4BB293-2D7F-4456-A681-1F22F42CD0BC\OUTPUT\Shell.efi
    echo Rename this EDK2 build to "BOOTX64.EFI" and copy to "\EFI\BOOT\BOOTX64.EFI" on target boot device
) else (
    echo.
    echo FATAL FAIL: EDK2\Build\Shell\RELEASE_VS2015\X64\ShellPkg\Application\Shell\EA4BB293-2D7F-4456-A681-1F22F42CD0BC\OUTPUT\Shell.efi doesn't exist
)