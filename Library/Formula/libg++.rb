require 'formula'

class Libgxx < Formula
  homepage 'ftp://gcc.gnu.org/pub/gcc/infrastructure/'
  url 'ftp://gcc.gnu.org/pub/gcc/infrastructure/libg++-2.8.1.3.tar.gz'
  sha1 'aafdb587d89c425a1b327977bfd688e8acfbaf42'

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
