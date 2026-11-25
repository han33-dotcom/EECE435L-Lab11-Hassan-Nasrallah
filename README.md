# EECE435L Lab 11 — Configuration and Deployment Tools

Hassan Nasrallah

Hello World is a console application that prints `Hello, World from Hassan_Nasrallah!` and exits. The Windows version is written in C++ and the Debian version in C.

| Deliverable | File |
| --- | --- |
| Windows x64 installer | [helloworld_Hassan_Nasrallah.msi](dist/helloworld_Hassan_Nasrallah.msi) |
| Debian amd64 installer | [helloworld_Hassan_Nasrallah.deb](dist/helloworld_Hassan_Nasrallah.deb) |
| Source archive | [source.zip](dist/source.zip) |
| Debian package metadata | [control](packaging/debian/control) |
| Windows Installer authoring | [HelloWorld.wxs](packaging/windows/HelloWorld.wxs) |
| User guide | [user_guide.txt](docs/user_guide.txt) |

## Windows x64

Build with MinGW-w64 g++ on PATH and the [WiX Toolset v3.14.1 binaries](https://github.com/wixtoolset/wix3/releases/tag/wix3141rtm) extracted locally. Run these commands in PowerShell from the repository root. Replace the WiX path with the directory containing `candle.exe` and `light.exe`.

```powershell
.\packaging\windows\build.ps1 -WixBin 'C:\Tools\WiX314'
msiexec.exe /i ".\dist\helloworld_Hassan_Nasrallah.msi"
& "$env:LOCALAPPDATA\HelloWorld-Hassan-Nasrallah\helloworld.exe"
```

Wait for setup to finish before running the executable. For removal, find **Hello World - Hassan Nasrallah** in **Settings → Apps → Installed apps**, or run `msiexec.exe /x ".\dist\helloworld_Hassan_Nasrallah.msi"`.

The MSI has one feature that installs the executable, README, and user guide. Each file belongs to its own component with a per-user registry key path. The directory tree places the files in `%LOCALAPPDATA%\HelloWorld-Hassan-Nasrallah`. Windows Installer uses the component key paths to track installation state.

## Debian amd64

On Debian 12 or a compatible Debian-based system, run these commands from the repository root.

```sh
sudo apt-get update
sudo apt-get install gcc libc6-dev dpkg
sh packaging/debian/build.sh
sudo apt install ./dist/helloworld_Hassan_Nasrallah.deb
dpkg -l helloworld-hassan-nasrallah
/usr/local/bin/helloworld
```

Run `sudo apt remove helloworld-hassan-nasrallah` to uninstall. The executable goes in `/usr/local/bin`, the location used in the lab handout. The README and user guide go in `/usr/share/doc/helloworld-hassan-nasrallah`. The `DEBIAN/control` file supplies package identity, version, architecture, dependency, maintainer, and description. Use `dpkg-deb --info` to inspect it and `dpkg-deb --contents` to list the installed files.

## Verification evidence

See [the build and installation evidence](evidence/). 
