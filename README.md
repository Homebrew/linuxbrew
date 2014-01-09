Linuxbrew
=========
An experimental fork of Homebrew for Linux.

Installation
------------

* Debian or Ubuntu: `sudo apt-get install build-essential curl git ruby libbz2-dev libexpat-dev`
* Fedora: `sudo yum groupinstall 'Development Tools' && sudo yum install curl git ruby bzip2-devel expat-devel`
* `git clone https://github.com/Homebrew/linuxbrew.git ~/.linuxbrew`
* Add to your `.bashrc` or `.zshrc`:

 ```sh
 export PATH="$HOME/.linuxbrew/bin:$PATH"
 export LD_LIBRARY_PATH="$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH"
 ```

* `brew install $WHATEVER_YOU_WANT`

What Packages Are Available?
----------------------------
1. You can [browse the Formula directory on GitHub](https://github.com/Homebrew/linuxbrew/tree/linuxbrew/Library/Formula).
2. Or type `brew search` for a list.
3. Or run `brew server` to browse packages off of a local web server.
4. Or visit [braumeister](http://braumeister.org) to browse packages online.

Requirement
-----------
* **Ruby** 1.8.6 or newer

More Documentation
------------------
`brew help` or `man brew` or check the Linuxbrew [wiki](https://github.com/Homebrew/linuxbrew/wiki).

Who Are You?
------------
Homebrew is maintained by the [core contributors][team].

Homebrew was originally created by [Max Howell][mxcl].

License
-------
Code is under the [BSD 2 Clause (NetBSD) license][license].

Donations
---------
We accept tips through [Gittip][tip].

[![Gittip](http://img.shields.io/gittip/Homebrew.png)](https://www.gittip.com/Homebrew/)

[home]:http://brew.sh
[wiki]:http://wiki.github.com/Homebrew/homebrew
[mxcl]:http://twitter.com/mxcl
[formula]:http://github.com/Homebrew/homebrew/tree/master/Library/Formula/
[braumeister]:http://braumeister.org
[license]:https://github.com/Homebrew/homebrew/tree/master/Library/Homebrew/LICENSE
[team]:https://github.com/Homebrew?tab=members
[tip]:https://www.gittip.com/Homebrew/
