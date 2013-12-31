require 'formula'

class Glib < Formula
  homepage 'http://developer.gnome.org/glib/'
  url 'http://ftp.gnome.org/pub/gnome/sources/glib/2.39/glib-2.39.2.tar.xz'
  sha256 '01c354a054774c836c8ccd286b4d6082797b67368a46e5b4d529dd770106d2f7'
  
  depends_on 'pkg-config' => :build
  #depends_on 'libtool'
  depends_on 'gettext'
  depends_on 'libffi'
  #depends_on 'zlib'
  #depends_on 'docbook'
  #depends_on 'python'
  #depends_on 'libxml2'
  #depends_on 'openssl'
  

  def patches
    p = {}
    p[:p1] = []
    # https://bugzilla.gnome.org/show_bug.cgi?id=673135 Resolved as wontfix,
    # but needed to fix an assumption about the location of the d-bus machine
    # id file.
    p[:p1] << "https://gist.github.com/jacknagel/6700436/raw/a94f21a9c5ccd10afa0a61b11455c880640f3133/glib-configurable-paths.patch"
    # Fixes compilation with FSF GCC. Doesn't fix it on every platform, due
    # to unrelated issues in GCC, but improves the situation.
    # Patch submitted upstream: https://bugzilla.gnome.org/show_bug.cgi?id=672777
    p[:p1] << "https://gist.github.com/mistydemeo/8c7eaf0940b6b9159779/raw/11b3b1f09d15ccf805b0914a15eece11685ea8a5/gio.diff"
    p[:p0] = "https://trac.macports.org/export/111532/trunk/dports/devel/glib2/files/patch-configure.diff" if build.universal?
    p
  end

  def install

    # Disable dtrace; see https://trac.macports.org/ticket/30413
    args = %W[
      --disable-maintainer-mode
      --disable-dependency-tracking
      --disable-silent-rules
      --disable-dtrace
      --disable-libelf
      --prefix=#{prefix}
      --localstatedir=#{var}
      --with-gio-module-dir=#{HOMEBREW_PREFIX}/lib/gio/modules
    ]

    system "./configure", *args

    system "make"
    # the spawn-multithreaded tests require more open files
    #system "ulimit -n 1024; make check" if build.include? 'test'
    system "make install"

    (share+'gtk-doc').rmtree
  end
end
