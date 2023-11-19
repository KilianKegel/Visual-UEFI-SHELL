@echo off

rem ######################################################
rem ### Tools bootstrap process
rem ######################################################

set path=%path%;%~dp0\Tools

rem #######################################################################
rem ### check/create MYDOWNLOADS ##########################################
rem #######################################################################
if defined MYDOWNLOADS (
    rem echo MYDOWNLOADS exist
) else (
    echo create MYDOWNLOADS locally
    mkdir MYDOWNLOADS
    echo set MYDOWNLOADS=%~dp0MYDOWNLOADS
    set MYDOWNLOADS=%~dp0MYDOWNLOADS
)

rem #######################################################################
rem ### get TOOLS #########################################################
rem #######################################################################
if not exist Tools (
    md Tools
)
if not exist %MYDOWNLOADS%\wget.exe powershell "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri "https://eternallybored.org/misc/wget/1.21.3/64/wget.exe -OutFile %MYDOWNLOADS%\wget.exe"}"
if not exist Tools\wget.exe copy %MYDOWNLOADS%\wget.exe Tools\wget.exe
if not exist %MYDOWNLOADS%\EnterpriseWDK_rs2_release_15063_20170317-1834.zip Tools\wget --no-check-certificate --output-document=%MYDOWNLOADS%\EnterpriseWDK_rs2_release_15063_20170317-1834.zip https://go.microsoft.com/fwlink/p/?LinkID=846038
if not exist %MYDOWNLOADS%\nasm-2.16.01-win64.zip               Tools\wget --no-check-certificate --output-document=%MYDOWNLOADS%\nasm-2.16.01-win64.zip https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/win64/nasm-2.16.01-win64.zip
if not exist %MYDOWNLOADS%\python-3.10.11-embed-win64.zip       Tools\wget --no-check-certificate --output-document=%MYDOWNLOADS%\python-3.10.11-embed-win64.zip https://www.python.org/ftp/python/3.10.11/python-3.10.11-embed-amd64.zip

rem #######################################################################
rem ### InstallCheck Tools \\\\\\\\\\######################################
rem #######################################################################
if not exist Tools\EWDK_1703 (
    echo EXTRACTING Microsoft Compiler and Build tools EWDK_1703 ...
    md Tools\EWDK_1703
    tar -xf %MYDOWNLOADS%\EnterpriseWDK_rs2_release_15063_20170317-1834.zip -C Tools\EWDK_1703 --exclude "Program Files(64)" --exclude "Program Files/Microsoft SDKs/Windows Phone" --exclude "Program Files/Microsoft Visual Studio 12.0" --exclude "Common Files" --exclude "CommonAppData" --exclude "MergeMod" --exclude "Program Files/Microsoft SDKs/Windows/v10.0A" --exclude "Program Files/Microsoft SDKs/Windows Phone" --exclude "Program Files/Microsoft Shared" --exclude "Program Files/Microsoft Visual Studio 12.0" --exclude "Program Files/Microsoft Visual Studio 14.0/VC/atlmfc" --exclude "Program Files/MSBuild" --exclude "Program Files/Reference Assemblies" --exclude "Program Files/Windows Kits/10/bin/10.0.15063.0/arm" --exclude "Program Files/Windows Kits/10/bin/10.0.15063.0/arm64" --exclude "Program Files/Windows Kits/10/bin/arm" --exclude "Program Files/Windows Kits/10/bin/arm64" --exclude "Program Files/Windows Kits/10/Catalogs" --exclude "Program Files/Windows Kits/10/Debuggers/arm" --exclude "Program Files/Windows Kits/10/Testing" --exclude "Program Files/Windows Kits/10/tools/arm" --exclude "Program Files/Windows Kits/10/tools/arm64" --exclude "System" --exclude "System64" --exclude "Utilities" --exclude "Windows" --exclude "Microsoft.NET" --exclude "Microsoft SDKs" --exclude "Microsoft" --exclude "CatalogInfo" --exclude "Windows Kits/NETFXSDK" --exclude "Windows Kits/8.1" --exclude "Windows Kits/10/build" --exclude "Windows Kits/10/BuildLabSupport" --exclude "Windows Kits/10/CodeAnalysis" --exclude "Windows Kits/10/CoreSystem" --exclude "Windows Kits/10/Credits.rtf" --exclude "Windows Kits/10/CrossCertificates" --exclude "Windows Kits/10/Debuggers" --exclude "Windows Kits/10/DesignTime" --exclude "Windows Kits/10/DeviceLayoutSamples" --exclude "Windows Kits/10/Docs" --exclude "Windows Kits/10/Extension SDKs" --exclude "Windows Kits/10/help" --exclude "Windows Kits/10/license.rtf" --exclude "Windows Kits/10/Manifests" --exclude "Windows Kits/10/Platforms" --exclude "Windows Kits/10/Redist" --exclude "Windows Kits/10/References" --exclude "Windows Kits/10/Relnote.htm" --exclude "Windows Kits/10/Remote" --exclude "Windows Kits/10/Samples" --exclude "Windows Kits/10/SDKManifest.xml" --exclude "Windows Kits/10/Shortcuts" --exclude "Windows Kits/10/Source" --exclude "Windows Kits/10/ToolFunnel" --exclude "Windows Kits/10/tools" --exclude "Windows Kits/10/UnionMetadata" --exclude "Windows Kits/10/wdk_arm_license.rtf" --exclude "Windows Kits/10/WPBootScreens" --exclude "Program Files/Microsoft Visual Studio 14.0/ImportProjects" --exclude "Program Files/Microsoft Visual Studio 14.0/lib" --exclude "Program Files/Microsoft Visual Studio 14.0/Licenses" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Alm.Shared.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Alm.Shared.Remoting.RemoteContainer.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.Conversion.Core.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.Conversion.Core.resources.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.CPPTasks.Common.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.Engine.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.Engine.resources.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.Framework.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.resources.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.Tasks.Core.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.Tasks.Core.resources.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.Tasks.v12.0.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.Tasks.v12.0.resources.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.Utilities.Core.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.Utilities.Core.resources.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.Utilities.v12.0.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.Build.Utilities.v12.0.resources.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.VisualStudio.Alm.Shared.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.VisualStudio.Debugger.Runtime.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Microsoft.VisualStudio.Diagnostics.ServiceModelSink.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/MSBuild.exe" --exclude "Program Files/Microsoft Visual Studio 14.0/MSBuild.resources.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/MSBuildTaskHost.resources.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/SDK" --exclude "Program Files/Microsoft Visual Studio 14.0/Silverlight" --exclude "Program Files/Microsoft Visual Studio 14.0/System.Collections.Immutable.dll" --exclude "Program Files/Microsoft Visual Studio 14.0/Team Tools" --exclude "Program Files/Microsoft Visual Studio 14.0/VB" --exclude "Program Files/Microsoft Visual Studio 14.0/VC#" --exclude "Program Files/Microsoft Visual Studio 14.0/Web" --exclude "Program Files/Microsoft Visual Studio 14.0/Xml" --exclude "Program Files/Microsoft Visual Studio 14.0/VC/bin/amd64_arm" --exclude "Program Files/Microsoft Visual Studio 14.0/VC/bin/x86_arm" --exclude "Program Files/Microsoft Visual Studio 14.0/VC/crt/src/arm" --exclude "Program Files/Microsoft Visual Studio 14.0/VC/lib/arm" --exclude "Program Files/Microsoft Visual Studio 14.0/VC/lib/onecore/arm" --exclude "Program Files/Microsoft Visual Studio 14.0/VC/lib/store/arm" --exclude "Program Files/Microsoft Visual Studio 14.0/VC/redist/arm" --exclude "Program Files/Microsoft Visual Studio 14.0/VC/redist/debug_nonredist/arm" --exclude "Program Files/Microsoft Visual Studio 14.0/VC/redist/GraphicsDbgRedist/ARM" --exclude "Program Files/Microsoft Visual Studio 14.0/VC/redist/onecore/arm" --exclude "Program Files/Microsoft Visual Studio 14.0/VC/redist/onecore/debug_nonredist/arm" --exclude "Program Files/Windows Kits/10/Lib/10.0.15063.0/km/arm" --exclude "Program Files/Windows Kits/10/Lib/10.0.15063.0/km/arm64" --exclude "Program Files/Windows Kits/10/Lib/10.0.15063.0/ucrt/arm" --exclude "Program Files/Windows Kits/10/Lib/10.0.15063.0/ucrt/arm64" --exclude "Program Files/Windows Kits/10/Lib/10.0.15063.0/um/arm" --exclude "Program Files/Windows Kits/10/Lib/10.0.15063.0/um/arm64" --exclude "Program Files/Windows Kits/10/Lib/wdf/kmdf/arm" --exclude "Program Files/Windows Kits/10/Lib/wdf/kmdf/arm64" --exclude "Program Files/Windows Kits/10/Lib/wdf/umdf/arm" --exclude "Program Files/Windows Kits/10/Lib/wdf/umdf/arm64" --exclude "Program Files/Windows Kits/10/Lib/win8/km/arm" --exclude "Program Files/Windows Kits/10/Lib/winv6.3/km/arm" --exclude "Program Files/Windows Kits/10/Include/wdf" --exclude "Program Files/Windows Kits/10/Lib/wdf" --exclude "Program Files/Windows Kits/10/Lib/win7" --exclude "Program Files/Windows Kits/10/Lib/win8" --exclude "Program Files/Windows Kits/10/Lib/winv6.3" --exclude "Program Files/Windows Kits/10/bin/10.0.15063.0" --exclude "Program Files/Windows Kits/10/bin/conversion" --exclude "Program Files/Windows Kits/10/bin/Microsoft.DriverKit.Telemetry.dll" --exclude "Program Files/Windows Kits/10/bin/microsoft.windowskits.feedback.exe" --exclude "Program Files/Windows Kits/10/bin/selfsign" --exclude "Program Files/Windows Kits/10/bin/wdksqmapi.dll" --exclude "Program Files/Windows Kits/10/bin/WppConfig" --exclude "Program Files/Windows Kits/10/bin/XamlCompiler" 
)

if not exist Tools\nasm-2.16.01 (
    echo EXTRACTING NASM ...
    md Tools\nasm-2.16.01
    tar -xf %MYDOWNLOADS%\nasm-2.16.01-win64.zip -C Tools\
)

if not exist Tools\python-3.10.11 (
    echo EXTRACTING PYTHON ...
    md Tools\python-3.10.11\Lib
    tar -xf %MYDOWNLOADS%\python-3.10.11-embed-win64.zip -C Tools\python-3.10.11
    tar -xf Tools\python-3.10.11\python310.zip -C Tools\python-3.10.11\Lib
    ren Tools\python-3.10.11\python310._pth python310.pth
)

set VCINSTALLDIR=%~dp0Tools\EWDK_1703\Program Files\Microsoft Visual Studio 14.0\VC\
set VS140COMNTOOLS=%VCINSTALLDIR%\..\Common7\Tools\
set INCLUDE=%~dp0Tools\EWDK_1703\Program Files\Windows Kits\10\Include\10.0.15063.0\ucrt\
set INCLUDE=%INCLUDE%;%~dp0Tools\EWDK_1703\Program Files\Microsoft Visual Studio 14.0\VC\include\
set INCLUDE=%INCLUDE%;%~dp0Tools\EWDK_1703\Program Files\Windows Kits\10\Include\10.0.15063.0\um\
set INCLUDE=%INCLUDE%;%~dp0Tools\EWDK_1703\Program Files\Windows Kits\10\Include\10.0.15063.0\shared;
set LIB=%~dp0Tools\EWDK_1703\Program Files\Microsoft Visual Studio 14.0\VC\lib\;%~dp0Tools\EWDK_1703\Program Files\Windows Kits\10\Lib\10.0.15063.0\um\x86\;%~dp0Tools\EWDK_1703\Program Files\Windows Kits\10\Lib\10.0.15063.0\ucrt\x86\

set path=%path%;%~dp0Tools\nasm-2.16.01
set NASM_PREFIX=%~dp0Tools\nasm-2.16.01\

rem ######################################################################
rem ### make RC.EXE available for tianocore EDK2
rem ######################################################################
set WINSDK81x86_PREFIX=%~dp0Tools\EWDK_1703\Program Files\Windows Kits\10\bin\
set WINSDK81_PREFIX=%~dp0Tools\EWDK_1703\Program Files\Windows Kits\10\bin\

del /s %~dp0Tools\EWDK_1703\vctip.exe

rem #######################################################################
rem ### invoke EWDK_1703 startup script ###################################
rem #######################################################################
pushd .
call Tools\EWDK_1703\LaunchBuildEnv.cmd x86
popd

rem #######################################################################
rem ### test build hello.c ################################################
rem #######################################################################
cl /nologo hello.c

rem #######################################################################
rem ### setup EDK2 build environment ######################################
rem #######################################################################
set EDK_TOOLS_PATH=%~dp0EDK2\BaseTools
if not exist EDK2\Conf mkdir EDK2\Conf
if not exist EDK2\Conf\target.txt (
    echo ACTIVE_PLATFORM       = ShellPkg\ShellPkg.dsc> EDK2\Conf\target.txt
    echo TARGET                = RELEASE>>              EDK2\Conf\target.txt
    echo TARGET_ARCH           = X64>>                  EDK2\Conf\target.txt
    echo TOOL_CHAIN_CONF       = Conf/tools_def.txt>>   EDK2\Conf\target.txt
    echo TOOL_CHAIN_TAG        = MYTOOLS>>              EDK2\Conf\target.txt
    echo BUILD_RULE_CONF = Conf/build_rule.txt>>        EDK2\Conf\target.txt
)

rem ######################################################################
rem ### PYTHONE_HOME
rem ######################################################################
REM for /F  %%a in ('where python.exe') do set PYTHON_HOME=%%~dpa
set path=%~dp0Tools\python-3.10.11;%path%
set PYTHON_HOME=%~dp0Tools\python-3.10.11
set PYTHONPATH=%~dp0Tools\python-3.10.11\Lib;%~dp0Tools\python-3.10.11\;
set PYTHON_COMMAND=%~dp0Tools\python-3.10.11\python.exe

pushd EDK2
set VS2015=1
call edksetup.bat Rebuild
popd


set path=%~dp0;%path%
echo ##################################################################################
echo ###                                                                            ###
echo ### enter "BUILD" to build the original tianocore shell                        ###
echo ###                                                                            ###
echo ###     NOTE: This step is also initially required to run Visual-UEFI-SHELL    ###
echo ###           build.                                                           ###
echo ###                                                                            ###
echo ### enter "rd /s /q build" to clean previous build                             ###
echo ###                                                                            ###
echo ##################################################################################

rem #######################################################################
rem ### start cmd.exe #####################################################
rem #######################################################################
if not "%~0" == "lauch32.bat" cmd.exe /k title SHELL BUILD

:EOF
