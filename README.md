### [Add Passwords to Chrome](https://github.com/warren-bank/chrome-add-password)

#### Purpose

Silly workaround to make it easier to manually add web site passwords into Chrome's password manager

#### Methodology

scripts to:

* starts a local web server
  * serves a static web site login form
* edit the _hosts_ file
  * temporarily resolve any website to the local web server

#### Usage - example

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

workaround:

* open: `chrome://net-internals/#hsts`
* under: _Delete domain_
  * enter domain
  * click delete
* under: _Query domain_
  * enter domain
  * click query
  * confirm: "Not found"

example domains:

* `accounts.google.com`
* `github.com`

observations:

* I've observed the following:
  * the settings page can be opened in an Incognito window
    * when a domain is deleted in an Incognito window
      * its settings are not deleted in the normal (non-incognito) context
      * its settings are restored when the Incognito window is closed, and a new Incognito window is opened
  * the settings page can be opened in a normal (non-incognito) window
    * when a domain is deleted in a normal window
      * its settings are restored when Chrome is restarted
        * warning:
          * I don't know whether this is true for all web sites
          * assuming that the same rules apply to restoring domains in both Incognito and normal windows, it may be wise to first test deletion of the domain in an Incognito window

#### Legal:

* copyright: [Warren Bank](https://github.com/warren-bank)
* license: [GPL-2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt)
