require 'formula'

class Python < Formula
  homepage 'http://www.python.org'
  head 'http://hg.python.org/cpython', :using => :hg, :branch => '2.7'
  url 'http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tgz'
  sha1 '8328d9f1d55574a287df384f4931a3942f03da64'

  option 'quicktest', "Run `make quicktest` after the build (for devs; may fail)"
  option 'with-brewed-openssl', "Use Homebrew's openSSL instead of the one from OS X"
  option 'with-brewed-tk', "Use Homebrew's Tk (has optional Cocoa and threads support)"
  option 'with-poll', "Enable select.poll, which is not fully implemented on OS X (http://bugs.python.org/issue5154)"
  option 'with-dtrace', "Experimental DTrace support (http://bugs.python.org/issue13405)"
  
  depends_on 'pkg-config' => :build
  depends_on 'readline' => :recommended
  depends_on 'sqlite' => :recommended
  depends_on 'gdbm' => :recommended
  depends_on 'openssl' if build.with? 'brewed-openssl'

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
  
  def patches
    # Patch to disable the search for Tk.framework, since Homebrew's Tk is
    # a plain unix build. Remove `-lX11`, too because our Tk is "AquaTk".
    DATA if build.with? 'brewed-tk'
  end
  
  def site_packages_cellar
    prefix/"lib/python2.7/site-packages"
  end
  # The HOMEBREW_PREFIX location of site-packages.
  def site_packages
    HOMEBREW_PREFIX/"lib/python2.7/site-packages"
  end

  def install
    opoo 'The given option --with-poll enables a somewhat broken poll() on OS X (http://bugs.python.org/issue5154).' if build.with? 'poll'

    # Unset these so that installing pip and setuptools puts them where we want
    # and not into some other Python the user has installed.
    ENV['PYTHONHOME'] = nil
    ENV['PYTHONPATH'] = nil
		
		ENV['CFLAGS'] = "-fPIC -shared  -static -ldl -rdynamic -Os -w -pipe -march=core2 -msse4"
		ENV['CXXFLAGS'] = "-fPIC -shared -static -ldl -rdynamic -Os -w -pipe -march=core2 -msse4"
		
    args = %W[
             --prefix=#{prefix}
             --enable-ipv6
             --datarootdir=#{share}
             --datadir=#{share}
             --disable-framework
           ]
           
     args << '--without-gcc' if ENV.compiler == :clang
     args << '--with-dtrace' if build.with? 'dtrace'
		 
     if superenv?
       distutils_fix_superenv(args)
     else
       distutils_fix_stdenv
     end
    
    # Allow sqlite3 module to load extensions: http://docs.python.org/library/sqlite3.html#f1      
    inreplace("setup.py", 'sqlite_defines.append(("SQLITE_OMIT_LOAD_EXTENSION", "1"))', '') if build.with? 'sqlite'
    
    # Allow python modules to use ctypes.find_library to find homebrew's stuff
    # even if homebrew is not a /usr/local/lib. Try this with:
    # `brew install enchant && pip install pyenchant`
    inreplace "./Lib/ctypes/macholib/dyld.py" do |f|
      f.gsub! 'DEFAULT_LIBRARY_FALLBACK = [', "DEFAULT_LIBRARY_FALLBACK = [ '#{HOMEBREW_PREFIX}/lib',"
      #f.gsub! 'DEFAULT_FRAMEWORK_FALLBACK = [', "DEFAULT_FRAMEWORK_FALLBACK = [ '#{HOMEBREW_PREFIX}/Frameworks',"
    end
    
		
    system "./configure", *args
    
    # HAVE_POLL is "broken" on OS X
    # See: http://trac.macports.org/ticket/18376 and http://bugs.python.org/issue5154
    inreplace 'pyconfig.h', /.*?(HAVE_POLL[_A-Z]*).*/, '#undef \1' unless build.with? "poll"
    
    system "make"
    
    ENV.deparallelize # Installs must be serialized
    system "make", "install"
    # Demos and Tools
    (HOMEBREW_PREFIX/'share/python').mkpath
    #system "make", "frameworkinstallextras", "PYTHONAPPSDIR=#{share}/python"
    #system "make", "quicktest" if build.include? 'quicktest'
    
    site_packages_cellar.rmtree
    site_packages.mkpath
    ln_s site_packages, site_packages_cellar
    
    # We ship setuptools and pip and reuse the PythonDependency
    # Requirement here to write the sitecustomize.py
    py = PythonDependency.new("2.7")
    py.binary = bin/'python'
    py.modify_build_environment

    # Remove old setuptools installations that may still fly around and be
    # listed in the easy_install.pth. This can break setuptools build with
    # zipimport.ZipImportError: bad local file header
    # setuptools-0.9.5-py3.3.egg
    rm_rf Dir["#{py.global_site_packages}/setuptools*"]
    rm_rf Dir["#{py.global_site_packages}/distribute*"]
    
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

  test do
    # Check if sqlite is ok, because we build with --enable-loadable-sqlite-extensions
    # and it can occur that building sqlite silently fails if OSX's sqlite is used.
    system "#{bin}/python", "-c", "import sqlite3"
  end
end

__END__
diff --git a/setup.py b/setup.py
index 716f08e..66114ef 100644
--- a/setup.py
+++ b/setup.py
@@ -1810,9 +1810,6 @@ class PyBuildExt(build_ext):
         # Rather than complicate the code below, detecting and building
         # AquaTk is a separate method. Only one Tkinter will be built on
         # Darwin - either AquaTk, if it is found, or X11 based Tk.
-        if (host_platform == 'darwin' and
-            self.detect_tkinter_darwin(inc_dirs, lib_dirs)):
-            return
 
         # Assume we haven't found any of the libraries or include files
         # The versions with dots are used on Unix, and the versions without
@@ -1858,21 +1855,6 @@ class PyBuildExt(build_ext):
             if dir not in include_dirs:
                 include_dirs.append(dir)

-        # Check for various platform-specific directories
-        if host_platform == 'sunos5':
-            include_dirs.append('/usr/openwin/include')
-            added_lib_dirs.append('/usr/openwin/lib')
-        elif os.path.exists('/usr/X11R6/include'):
-            include_dirs.append('/usr/X11R6/include')
-            added_lib_dirs.append('/usr/X11R6/lib64')
-            added_lib_dirs.append('/usr/X11R6/lib')
-        elif os.path.exists('/usr/X11R5/include'):
-            include_dirs.append('/usr/X11R5/include')
-            added_lib_dirs.append('/usr/X11R5/lib')
-        else:
-            # Assume default location for X11
-            include_dirs.append('/usr/X11/include')
-            added_lib_dirs.append('/usr/X11/lib')
 
         # If Cygwin, then verify that X is installed before proceeding
         if host_platform == 'cygwin':
@@ -1897,9 +1879,6 @@ class PyBuildExt(build_ext):
         if host_platform in ['aix3', 'aix4']:
             libs.append('ld')
 
-        # Finally, link with the X11 libraries (not appropriate on cygwin)
-        if host_platform != "cygwin":
-            libs.append('X11')
 
         ext = Extension('_tkinter', ['_tkinter.c', 'tkappinit.c'],
                         define_macros=[('WITH_APPINIT', 1)] + defs,
