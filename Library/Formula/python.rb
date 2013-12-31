require 'formula'

class Python < Formula
  homepage 'http://www.python.org'
  head 'http://hg.python.org/cpython', :using => :hg, :branch => '2.7'
  url 'http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tgz'
  sha1 '8328d9f1d55574a287df384f4931a3942f03da64'


  depends_on 'pkg-config' => :build
  depends_on 'readline'
  depends_on 'sqlite'
  depends_on 'gdbm'
  depends_on 'openssl' 

  skip_clean 'bin/pip', 'bin/pip-2.7'
  skip_clean 'bin/easy_install', 'bin/easy_install-2.7'

  resource 'setuptools' do
    url 'https://pypi.python.org/packages/source/s/setuptools/setuptools-1.3.2.tar.gz'
    sha1 '77180132225c5b4696e6d061655e291f3d1b20f5'
  end

  resource 'pip' do
    url 'https://pypi.python.org/packages/source/p/pip/pip-1.4.1.tar.gz'
    sha1 '9766254c7909af6d04739b4a7732cc29e9a48cb0'
  end

  def site_packages_cellar
    prefix/"lib/python2.7/site-packages"
  end
  # The HOMEBREW_PREFIX location of site-packages.
  def site_packages
    HOMEBREW_PREFIX/"lib/python2.7/site-packages"
  end

  def install
    ENV['PYTHONHOME'] = nil
    ENV['PYTHONPATH'] = nil

    args = %W[
             --prefix=#{prefix}
             --enable-ipv6
             --datarootdir=#{share}
             --datadir=#{share}
             --with-system-expat
             --with-system-ffi
             --with-dec-threads
             --with-pth
           ]
    inreplace("setup.py", 'sqlite_defines.append(("SQLITE_OMIT_LOAD_EXTENSION", "1"))', '') if build.with? 'sqlite'
    system "./configure", *args
    system "make"
    system "make", "install"
    
    # Demos and Tools
    (HOMEBREW_PREFIX/'share/python').mkpath
    site_packages_cellar.rmtree
    site_packages.mkpath
    ln_s site_packages, site_packages_cellar
    
    # We ship setuptools and pip and reuse the PythonDependency
    # Requirement here to write the sitecustomize.py
    py = PythonDependency.new("2.7")
    py.binary = bin/'python'
    py.modify_build_environment


    setup_args = [ "-s", "setup.py", "--no-user-cfg", "install", "--force", "--verbose",
                   "--install-scripts=#{bin}", "--install-lib=#{site_packages}" ]

    resource('setuptools').stage { system py.binary, *setup_args }
    resource('pip').stage { system py.binary, *setup_args }

    # And now we write the distutils.cfg
    cfg = prefix/"lib/python2.7/distutils/distutils.cfg"
    cfg.delete if cfg.exist?
    cfg.write <<-EOF.undent
      [global]
      verbose=1
      [install]
      force=1
      prefix=#{HOMEBREW_PREFIX}
    EOF

    # Work-around for that bug: http://bugs.python.org/issue18050
    inreplace "#{prefix}/lib/python2.7/re.py", 'import sys', <<-EOS.undent
      import sys
      try:
          from _sre import MAXREPEAT
      except ImportError:
          import _sre
          _sre.MAXREPEAT = 65535 # this monkey-patches all other places of "from _sre import MAXREPEAT"'
      EOS
  end

  def distutils_fix_superenv(args)
    cflags = "CFLAGS=-I#{HOMEBREW_PREFIX}/include -I#{Formula.factory('sqlite').opt_prefix}/include"
    ldflags = "LDFLAGS=-L#{HOMEBREW_PREFIX}/lib -L#{Formula.factory('sqlite').opt_prefix}/lib"

    args << cflags
    args << ldflags

    # superenv handles that cc finds includes/libs!
    inreplace "setup.py",
              "do_readline = self.compiler.find_library_file(lib_dirs, 'readline')",
              "do_readline = '#{HOMEBREW_PREFIX}/opt/readline/lib/libhistory.dylib'"
  end

  def distutils_fix_stdenv()
    ENV.minimal_optimization
    ENV.enable_warnings
  end
  
  def caveats
    <<-EOS.undent
      Python demo
        #{HOMEBREW_PREFIX}/share/python/Extras

      Setuptools and Pip have been installed. To update them
        pip install --upgrade setuptools
        pip install --upgrade pip

      To symlink "Idle" and the "Python Launcher" to ~/Applications
        `brew linkapps`

      You can install Python packages with (the outdated easy_install or)
        `pip install <your_favorite_package>`

      They will install into the site-package directory
        #{site_packages}

      See: https://github.com/mxcl/homebrew/wiki/Homebrew-and-Python
    EOS
  end
end
