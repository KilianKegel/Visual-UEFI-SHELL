# <img src="https://github.com/KilianKegel/pictures/blob/master/New-icon.png"  width="48" height="48">EDK2-UEFI-SHELL + Toro-UEFI-SHELL
Build **UEFI SHELL binary** from latest available [**EDK2**](https://github.com/tianocore/edk2) [release tag](https://github.com/tianocore/edk2/tags)

![screnshot](https://github.com/KilianKegel/pictures/blob/master/torouefishell.png)

VIDEO: https://www.youtube.com/watch?v=wXTQ_wsKwHw

* [Intention](README.md#intention)<br>
  * [Download](https://github.com/KilianKegel/Visual-UEFI-SHELL/tree/main/UEFIBinaries)<br>
* [Goal](README.md#goal)<br>
* [Approach](README.md#approach)<br> 
* [Howto](README.md#howto)<br>
* [Revision history](README.md#revision-history)<br>


## Intention
***Tianocore community*** doesn't provide **UEFI SHELL binaries** anymore.
The discontinuation was announced with https://edk2.groups.io/g/devel/topic/patch_shellbinpkg_remove/31209298?p=.

***Tianocore community*** promised to *"publish all Shell binaries to the according Assets part directly. edk2 release link: https://github.com/tianocore/edk2/releases"*

Regrettably the latest available `ShellBinPkg` was published with  [edk2-stable202002](https://github.com/tianocore/edk2/releases?page=2) and is somehow out-dated.

https://github.com/tianocore/edk2/blob/edk2-stable201903/ShellBinPkg/UefiShell/X64/Shell.efi provides access to the latest available **UEFI SHELL binary**,
and is even more out-dated.

So this is a pretty bad situation for **UEFI SHELL users** (e.g. computer industry's test engineers, BIOS engineers),
since they have to build **UEFI SHELL** on their own to get an *up-to-date* version.

The latest **Visual UEFI SHELL Binary** can be found here: <br>
https://github.com/KilianKegel/Visual-UEFI-SHELL/tree/main/UEFIBinaries

## Goal
Introduce **♉toro UEFI SHELL**, an improved *original* **Tianocore UEFI SHELL** for engineers usage and development requirements.

### Development improvements:
* provide original **Visual Studio VS2022** tool chain for **Tianocore UEFI SHELL** 
	* speedup build time
	* [modern development experience](https://developer.ibm.com/blogs/the-modern-developer-experience/)
	* complete **Visual Studio** look and feel
* add **ANSI-C-API** ([**toro C Library** source code](https://github.com/KilianKegel/Visual-TORO-C-LIBRARY-for-UEFI/tree/498701ffff5c49492537f4ee16fe227d7e0fe0a8#torosrc)) as an additional standardized application		
  programming interface (API) for internal usage.
* based ond the above statement, create internally a **PLUGIN-mechanism**
  to easily insert .EFI-binaries directly into **UEFI SHELL** as additional shell commands:<br>
  * `diskpart` original binary from [Intel UEFI Shell Disk Utilities](https://www.intel.com/content/www/us/en/download/714351/uefi-shell-disk-utilities.html)
  * `acpibin`, `acpidump`, `aslcompiler` original binary from [ACPICA (ACPI component architecture) port to UEFI](https://github.com/tianocore/edk2-staging/tree/CdePkg/blogs/2022-01-16#introduction-of-the-acpica-port-to-uefi) at Tianocore.
  * `find`, `more` MSDOS clones  from [Visual-MSDOS-Tools-for-UEFI-Shell](https://github.com/KilianKegel/Visual-MSDOS-Tools-for-UEFI-Shell#visual-msdos-tools-for-uefi-shell)
  * `rtcdmp` RTC dump, and `siodmp` universal SuperIO dump.
	* just invoke `help` in the command line

*This enables developers to speed up their **UEFI SHELL**-development tasks by factor x10 or more*

### Usage improvements:
* add conventional MSDOS-style drive names **A:**, **B:**, **C:**, ...
* introduce `\EFI\BOOT\BOOTX64.INI` configuration file
* initially at boot switch to predefined screen resolution
* remove annoying **UEFI SHELL** count down at start
* provide key **F5** while *Starting UEFI Operating System ...* to skip `STARTUP.NSH`
## Approach
Provide **UEFI SHELL** build process with the complete set of all 
required build tools for Windows 10/11 machines running the AMD64 instruction set:
* **Microsoft EWDK 1703** [EnterpriseWDK_rs2_release_15063_20170317-1834.zip](https://go.microsoft.com/fwlink/p/?LinkID=846038)
* **Python 3.10.11** [python-3.10.11-embed-amd64.zip](https://www.python.org/ftp/python/3.10.11/python-3.10.11-embed-amd64.zip)
* **NASM 2.16.01** [nasm-2.16.01-win64.zip](https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/win64/nasm-2.16.01-win64.zip)

Additionally provide **Microsoft Visual Studio VS2022** support for that particular **Tianocore EDK2** component `ShellPkg`,
to enable developers to build, navigate through, explore, modify, extend and easily understand basic concepts of **UEFI SHELL** using **AI-assisted IntelliSense**
of **VS2022** – a state of the art integrated development environment.

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
4. start `VisualUEFIShell.sln` VS2022 solution from explorer – do *not* start from the above LAUNCHed command line<br>
   NOTE: EDK2 build automatically creates source code files *that must already be available* for **VS2022** usage
5. **VS2022** directly creates a `BOOTX64.EFI` **UEFI SHELL** binary in its output directory `UEFIBinaries`

## Revision history
### 20240829 v1.202408.0 build 41
* update to [**edk2-stable202408**](https://github.com/tianocore/edk2/releases/tag/edk2-stable202408)
* improve version enumeration: MINORVER is EDK2 stable release date
### 20240529 v1.6.0 build 31
* update to [**edk2-stable202405**](https://github.com/tianocore/edk2/releases/tag/edk2-stable202405)
### 20240225 v1.5.0 build 23
* update to [**edk2-stable202402**](https://github.com/tianocore/edk2/releases/tag/edk2-stable202402)
* improve portability, auto-download and setup of all required build tools
### 20240204 v1.4.0 build 22
* [fixed MORE.EFI swallows empty lines](https://github.com/KilianKegel/Visual-MSDOS-Tools-for-UEFI-Shell?tab=readme-ov-file#20240202)
* improved CTRL-C: CTRL-upcase-C not supported by traditional **TIANOCORE UEFI SHELL** and drives users mad.
  Now **CTRL-C** *&&* **ctrl-c** breaks.
* add famous RU.EFI binary as a PLUGIN
![RUEFISCREENSHOT](https://github.com/KilianKegel/pictures/blob/master/RUEFI.png)
### 20240114 v1.3.1 build 11
* rearrange HELP listing for PLUGIN commands, listed below
### 20240107 v1.3.0 build 4
* adding PLUGINS from [my-legacy-toolbox](https://github.com/tianocore/edk2-staging/blob/CdePkg/blogs/2021-11-14/README.md#my-legacy-toolbox) to Shell-internal command set
	* **PCI dump family**<br>			
	  * pcidmp32.efi, pcidmp16.efi, pcidmp8.efi<br>
	  NOTE: **pcidmp32.efi** supports "/ALL" command line switch to dump all PCI devices recursively
	
	* **PCI write family**<br>			
      * pciwr32.efi, pciwr16.efi, pciwr8.efi

	* **MEMory dump family**<br>					
      * memdmp64.efi, memdmp32.efi, memdmp16.efi, memdmp8.efi

	* **MEMory write family**<br>					
 	  * memwr64.efi, memwr32.efi, memwr16.efi, memwr8.efi

	* **I/O dump family**<br>					
      * iodmp32.efi, iodmp16.efi, iodmp8.efi

	* **I/O write family**<br>					
      * iowr32.efi, iowr16.efi, iowr8.efi

	* **RTC write**<br>									
      * rtcwr8.efi

	* **RTC dump**<br>									
	  * rtcdmp8.efi
* add version + build enumeration (experimental)

### 20231201
* update to [**edk2-stable202311**](https://github.com/tianocore/edk2/releases/tag/edk2-stable202311)
* add `DEFAULT_UEFI_DRIVE_NAMING` switch to **BOOTX64.INI**, to enable UEFI default drive naming **FS0:**, **FS1:**, **FS2:** ...
### 20231119
* update to **TORO C Library 20231118**
    * add ACPI timer based synchronization
### 20231029
* add plugins: 
	* **PCIView**
	* **DiskPart** from https://www.intel.com/content/www/us/en/download/714351/uefi-shell-disk-utilities.html
	* **AslCompiler**, **AslDump** from https://github.com/tianocore/edk2-staging/tree/CdePkg/blogs/2022-01-16#introduction-of-the-acpica-port-to-uefi
### 20230917
* introduce **toro UEFI SHELL**, *ALPHA*
* update to **TORO C Library 20230916**
### 20230826
* update to [**edk2-stable202308**](https://github.com/tianocore/edk2/releases/tag/edk2-stable202308)
* keep binaries in the directory **UEFIBinaries**
### 20230708
* update/facelift **BUILD.CMD** and **README.MD**
### 20230604
* update to [**edk2-stable202305**](https://github.com/tianocore/edk2/releases/tag/edk2-stable202305)
### 20230519
* add VS2022 GUI support to edit/navigate/postprocess/(partially)build **BOOTX64.EFI**: `VisualUEFIShell\VisualUEFIShell.sln`<br>
  **NOTE:** VS2022 build is based on prior EDK2-build preprocessed `AutoGen.h`, `AutoGen.c` and `*StrDefs.h`.
### 20230512
* fix Visual Studio installation and configuration to run on platforms with VS20XY already installed
### 20230507
* fix embedded Python installation and configuration to run on platforms without Python previously installed
### 20230501
* [**edk2-stable202302**](https://github.com/tianocore/edk2/releases/tag/edk2-stable202302)
* initial revision
