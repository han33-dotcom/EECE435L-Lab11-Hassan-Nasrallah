param(
    [Parameter(Mandatory)]
    [string]$WixBin
)

$ErrorActionPreference = 'Stop'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
$wix = (Resolve-Path -LiteralPath $WixBin).Path
$build = Join-Path $repo 'build/windows'
$payload = Join-Path $build 'payload'
$dist = Join-Path $repo 'dist'
New-Item -ItemType Directory -Force -Path $payload, $dist | Out-Null

$architecture = & g++ -dumpmachine
if ($LASTEXITCODE -ne 0 -or $architecture -notlike 'x86_64-*mingw*') {
    throw 'An x86_64 MinGW-w64 g++ compiler is required.'
}

$binary = Join-Path $payload 'helloworld.exe'
Write-Host 'g++ -std=c++17 -O2 -Wall -Wextra -Werror -pedantic -static src/windows/helloworld.cpp'
& g++ -std=c++17 -O2 -Wall -Wextra -Werror -pedantic -static -o $binary (Join-Path $repo 'src/windows/helloworld.cpp')
if ($LASTEXITCODE -ne 0) { throw 'C++ compilation failed.' }
Copy-Item -LiteralPath (Join-Path $repo 'README.md'), (Join-Path $repo 'docs/user_guide.txt') -Destination $payload

$object = Join-Path $build 'HelloWorld.wixobj'
$msi = Join-Path $dist 'helloworld_Hassan_Nasrallah.msi'
Write-Host 'candle.exe -arch x64 packaging/windows/HelloWorld.wxs'
& (Join-Path $wix 'candle.exe') -nologo -arch x64 "-dPayloadDir=$payload" -out $object (Join-Path $PSScriptRoot 'HelloWorld.wxs')
if ($LASTEXITCODE -ne 0) { throw 'WiX compilation failed.' }
Write-Host 'light.exe -out dist/helloworld_Hassan_Nasrallah.msi HelloWorld.wixobj'
& (Join-Path $wix 'light.exe') -nologo -spdb -out $msi $object
if ($LASTEXITCODE -ne 0) { throw 'WiX linking or MSI validation failed.' }
Write-Host 'Built dist/helloworld_Hassan_Nasrallah.msi'
