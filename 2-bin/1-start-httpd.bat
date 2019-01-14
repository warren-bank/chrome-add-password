@echo off
setlocal enabledelayedexpansion

set devd_external=C:\PortableApps\devd
set devd_internal=%~dp0..\3-dep\devd

if exist "%devd_external%\devd.exe" (
  set devd_home=%devd_external%
) else (
  set devd_home=%devd_internal%
)

rem :: self-signed TLS certificate => $HOME/.devd.cert
set HOME=!devd_home!

set devd_exe="!devd_home!\devd.exe"

cd "%~dp0..\1-www"

set devd_options=--port=80 --all
start "web server" !devd_exe! %devd_options% .

set devd_options=--port=443 --all --tls
start "web server" !devd_exe! %devd_options% .

endlocal
