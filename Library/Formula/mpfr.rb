require 'formula'

class Mpfr < Formula
  homepage 'http://www.mpfr.org/'
  # Upstream is down a lot, so use the GNU mirror + Gist for patches
  url 'http://ftpmirror.gnu.org/mpfr/mpfr-3.1.2.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/mpfr/mpfr-3.1.2.tar.bz2'
  sha1 '46d5a11a59a4e31f74f73dd70c5d57a59de2d0b4'

  depends_on 'gmp'

  def install
    args = ["--disable-dependency-tracking", "--prefix=#{prefix}"]

    system "./configure", *args
    system "make"
    system "make check"
    system "make install"
  end
end
