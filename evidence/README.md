# Build and installation evidence

The command-output screenshots show transcripts from the package builds, metadata inspection and installation tests. The text files contain the same output for search and accessibility. Local workspace path prefixes were removed from the WiX build transcript.

| Check | Screenshot | Transcript |
| --- | --- | --- |
| Windows MSI build with WiX | [MSI build](msi-build.png) | [Text](msi-build.txt) |
| Windows Installer properties, installation and application execution | [MSI verification](msi-install.png) | [Text](msi-install.txt) |
| Windows Settings registration for the installed app | [Installed apps](windows-installed-apps.png) | |
| Debian build, package metadata and file listing | [DEB build](deb-build.png) | [Text](deb-build.txt) |
| Debian installation, dpkg registration and application execution | [DEB verification](deb-install.png) | [Text](deb-install.txt) |

The Settings screenshot is cropped to the filtered Installed apps list. The WiX ICE91 warnings refer to the package's per-user file paths. This installer intentionally uses per-user scope.
