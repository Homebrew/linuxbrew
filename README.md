Linuxbrew
=========

An experimental fork of Homebrew for Linux.

Features
--------

+ Can install software to a home directory and so does not require sudo
+ Install software not packaged by the native distribution
+ Install up-to-date versions of software when the native distribution is old
+ Use the same package manager to manage both your Mac and Linux machines 

Installation
------------

* Debian or Ubuntu: `sudo apt-get install build-essential curl git ruby libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev texinfo`
* Fedora: `sudo yum groupinstall 'Development Tools' && sudo yum install curl git ruby bzip2-devel curl-devel expat-devel ncurses-devel zlib-devel texinfo`
* `git clone https://github.com/Homebrew/linuxbrew.git ~/.linuxbrew`
* Add to your `.bashrc` or `.zshrc`:

 ```sh
 export PATH="$HOME/.linuxbrew/bin:$PATH"
 export LD_LIBRARY_PATH="$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH"
 ```

* `brew install $WHATEVER_YOU_WANT`

Requirements
------------

* **Ruby** 1.8.6 or newer
+ **GCC** 4.2 or newer

What Packages Are Available?
----------------------------
1. You can [browse the Formula directory on GitHub][formula].
2. Or type `brew search` for a list.
3. Or visit [braumeister.org][braumeister] to browse packages online.

More Documentation
------------------
`brew help` or `man brew` or check our [wiki][].

Troubleshooting
---------------
First, please run `brew update` and `brew doctor`.

Second, read the [Troubleshooting Checklist](https://github.com/Homebrew/homebrew/wiki/troubleshooting).

**If you don't read these it will take us far longer to help you with your problem.**

Who Are You?
------------
Homebrew's current maintainers are [Misty De Meo][mistydemeo], [Adam Vandenberg][adamv], [Jack Nagel][jacknagel], [Mike McQuaid][mikemcquaid] and [Brett Koonce][asparagui].

Homebrew was originally created by [Max Howell][mxcl].

License
-------
Code is under the [BSD 2 Clause (NetBSD) license][license].

Donations
---------
We accept tips through [Gittip][tip].

[![Gittip](http://img.shields.io/gittip/Homebrew.svg)](https://www.gittip.com/Homebrew/)

[home]:http://brew.sh
[wiki]:https://github.com/Homebrew/homebrew/wiki
[mistydemeo]:https://github.com/mistydemeo
[adamv]:https://github.com/adamv
[jacknagel]:https://github.com/jacknagel
[mikemcquaid]:https://github.com/mikemcquaid
[asparagui]:https://github.com/asparagui
[mxcl]:https://github.com/mxcl
[formula]:https://github.com/Homebrew/homebrew/tree/master/Library/Formula/
[braumeister]:http://braumeister.org
[license]:https://github.com/Homebrew/homebrew/tree/master/LICENSE.txt
[tip]:https://www.gittip.com/Homebrew/
