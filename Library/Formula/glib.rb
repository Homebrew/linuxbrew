require 'formula'

class Glib < Formula
  homepage 'http://developer.gnome.org/glib/'
  url 'http://ftp.gnome.org/pub/gnome/sources/glib/2.38/glib-2.38.2.tar.xz'
  sha256 '056a9854c0966a0945e16146b3345b7a82562a5ba4d5516fd10398732aea5734'

  depends_on 'pkg-config' => :build
  depends_on 'gettext'
  depends_on 'libffi'

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
    p
  end

  def install
    args = %W[
      --enable-dependency-tracking
      --prefix=#{prefix}
      --localstatedir=#{var}
      --with-gio-module-dir=#{HOMEBREW_PREFIX}/lib/gio/modules
    ]

    system "./configure", *args

    system "make"
    system "make install"

    (share+'gtk-doc').rmtree
  end
end
