@echo off

echo edit "hosts":
echo add line to temporarily resolve web site to local httpd
echo.
echo example:
echo 127.0.0.1 accounts.google.com
echo.
echo then:
echo * open fake login form in Chrome
echo     http://accounts.google.com/index.html
echo * enter credentials
echo * allow Chrome to save the password
echo.

set hosts_file="C:\Windows\System32\Drivers\etc\hosts"
notepad %hosts_file%
