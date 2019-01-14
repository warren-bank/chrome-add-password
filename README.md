### [Add Passwords to Chrome](https://github.com/warren-bank/chrome-add-password)

#### Purpose

Silly workaround to make it easier to manually add web site passwords into Chrome's password manager

#### Methodology

scripts to:

* starts a local web server
  * serves a static web site login form
* edit the _hosts_ file
  * temporarily resolve any website to the local web server

#### Usage

run:

```text
call ./2-bin/1-start-httpd.bat
call ./2-bin/2-edit-hosts.bat
```

add line to the _hosts_ file:

```text
127.0.0.1 accounts.google.com
```

open in Chrome:

```text
http://accounts.google.com/index.html
```

then:

* enter login credentials in form fields
* submit
* confirm that Chrome should save the password
* remove line from the _hosts_ file

#### Notes:

* Chrome has intentionally chosen to [not allow saving passwords in Incognito mode](https://bugs.chromium.org/p/chromium/issues/detail?id=328862)
* the local web server doesn't read or write any cookies
  * after the _hosts_ file is restored, any pre-existing session(s) will be uneffected

#### Advanced Configs:

issue:

* some HTTPS websites report:
  ```text
    Your connection is not private

    NET::ERR_CERT_AUTHORITY_INVALID

    SITE normally uses encryption to protect your information.
    When Google Chrome tried to connect to SITE this time,
    the website sent back unusual and incorrect credentials.
    This may happen when an attacker is trying to pretend to be SITE...

    You cannot visit SITE right now because the website uses HSTS.
    Network errors and attacks are usually temporary, so this page will probably work later.
  ```

documentation to explain the cause:

* [_Strict-Transport-Security_ response header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security)

workaround option &num;1 _(preferred)_:

* open: `chrome://net-internals/#hsts`
* under: _Delete domain_
  * enter domain
  * click delete
* under: _Query domain_
  * enter domain
  * click query
  * confirm: "Not found"

workaround option &num;2:

* use a local HTTPS web server that supports sending custom HTTP response headers
  * send: "Strict-Transport-Security: max-age=0"
* configure Chrome to trust the self-signed certificate used by the local HTTPS web server
  * _Settings > Advanced > Manage Certificates > Trusted Root Certification Authorities > Import..._
* follow the normal [_usage_](#usage) pattern, but open the web page in Chrome with HTTPS
* remove the self-signed certificate used by the local HTTPS web server from Chrome's certificate store

notes:

* after the _hosts_ file has been reverted, such that the web page loads from its real origin
  * the server response will include the _Strict-Transport-Security_ header
  * the Chrome settings will revert to the value(s) specified in the server response

example domains:

* `accounts.google.com`
* `github.com`

#### Legal:

* copyright: [Warren Bank](https://github.com/warren-bank)
* license: [GPL-2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt)
