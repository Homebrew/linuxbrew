require 'formula'

class Cctools < Formula
  homepage ''
  url 'ftp://gcc.gnu.org/pub/gcc/infrastructure/cctools-590.36.tar.bz2'
  sha1 '1e3b09df0af271295a8c3fcf2c6588298dee7fb0'
  
  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"

    system "make install" 
  end
end
