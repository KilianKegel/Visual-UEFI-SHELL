# <img src="https://github.com/KilianKegel/pictures/blob/master/New-icon.png"  width="48" height="48">EDK2-UEFI-SHELL + Visual-UEFI-SHELL
Build **UEFI SHELL binary** from latest available [**EDK2**](https://github.com/tianocore/edk2)
[release tag](https://github.com/tianocore/edk2/tags)

* [Intention](README.md#intention)<br>
* [Goal](README.md#goal)<br>
* [Approach](README.md#approach)<br>* 
* [Howto](README.md#howto)<br>
* [Revision history](README.md#revision-history)<br>


## Intention
***Tianocore community*** doesn't provide **UEFI SHELL binaries** anymore.
The discontinuation was announced with https://edk2.groups.io/g/devel/topic/patch_shellbinpkg_remove/31209298?p=.

***Tianocore community*** promised to *"publish all Shell binaries to the according Assets part directly. edk2 release link: https://github.com/tianocore/edk2/releases"*

Regrettably the latest available `ShellBinPkg` was published with  [edk2-stable202002](https://github.com/tianocore/edk2/releases?page=2) and is somehow out-dated.

https://github.com/tianocore/edk2/blob/edk2-stable201903/ShellBinPkg/UefiShell/X64/Shell.efi provides access to the latest available **UEFI SHELL binary** direct access,
and is even more out-dated.

So this is a pretty bad situation for **UEFI SHELL users** (e.g. computer industry's test engineers, BIOS engineers),
since they have to build **UEFI SHELL** on their own to get an *up-to-date* version.

## Goal
Provide **UEFI SHELL** build process with the complete set of all 
required build tools for Windows 10/11 machines running the AMD64 instruction set:
* **Microsoft EWDK 1703** [EnterpriseWDK_rs2_release_15063_20170317-1834.zip](https://go.microsoft.com/fwlink/p/?LinkID=846038)
* **Python 3.10.11** [python-3.10.11-embed-amd64.zip](https://www.python.org/ftp/python/3.10.11/python-3.10.11-embed-amd64.zip)
* **NASM 2.16.01** [nasm-2.16.01-win64.zip](https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/win64/nasm-2.16.01-win64.zip)

Additionally provide **Microsoft Visual Studio VS2022** support for that particular **Tianocore EDK2** component `ShellPkg`,
to enable developers to build, navigate through, explore, modify, extend and easily understand basic concepts of **UEFI SHELL** using **AI-assisted IntelliSense**
of **VS2022** – a state of the art integrated development environment.

## Approach
The above tool set is automatically downloaded, extracted and setup during **LAUNCH.BAT** project start.

To speedup repeated installations (avoid repeated downloads of huge tool images),
the images may be –initially– stored permanently in local folder/share, beyond an environment variable
**MYDOWNLOADS**.

To do so:
* create a folder **%USERPROFILE%\MYDOWNLOADS**
* create the environment variable **MYDOWNLOADS** and assign the above folder location to it:
	* insert *WINDOWS-R* + *control.exe*
	* select *User Accounts*
	* select *Change my environment variables*
	* create a NEW environment variable 
		* Variable name: **MYDOWNLOADS**
		* Variable value: **%USERPROFILE%\MYDOWNLOADS**

### Using the Enterprise WDK
https://learn.microsoft.com/en-us/windows-hardware/drivers/develop/using-the-enterprise-wdk

The Enterprise Windows Driver Kit (Enterprise WDK) is a command-line build environment that does not require any installation prior to use. Once you have downloaded the EWDK, you can manage it with version control software or you can zip the files and copy as needed. A .zip file created with the Enterprise WDK contains all the necessary compilers, linkers, build tools, headers and libs to build Visual Studio-based driver projects.

The Enterprise WDK contains the necessary elements to build drivers and basic Win32 driver test applications. Use your favorite code editor to modify source code and project files. Because it is command-line based, the Enterprise WDK does lack some of the features incorporated into Visual Studio, such as an IDE, driver deployment and driver testing.

## Howto
0. download project recursively
1. run `LAUNCH.BAT` to start the session
2. run `BUILD` (build.cmd), to run the traditional EDK2 build

to run **VS2022**

3. you need steps 0. .. 2. from above
4. run `VisualUEFIShell.sln` VS2022 solution<br>
   NOTE: EDK2 build automatically creates source code files that must already be available for **VS2022** usage
5. **VS2022** directly creates a `BOOTX64.EFI` **UEFI SHELL** binary in its output directory `x64\Release`



## Revision history
### 20230519
* add VS2022 GUI support to edit/navigate/postprocess/(partially)build **BOOTX64.EFI**: `VisualUEFIShell\VisualUEFIShell.sln`<br>
  **NOTE:** VS2022 build is based on prior EDK2-build preprocessed `AutoGen.h`, `AutoGen.c` and `*StrDefs.h`.
### 20230512
* fix Visual Studio installation and configuration to run on platforms with VS20XY already installed
### 20230507
* fix embedded Python installation and configuration to run on platforms without Python previously installed
### 20230501
* edk2-stable202302
* initial revision
