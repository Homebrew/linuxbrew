require 'formula'

class Gdbm < Formula
  homepage 'http://www.gnu.org/software/gdbm/'
  url 'http://ftpmirror.gnu.org/gdbm/gdbm-1.10.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/gdbm/gdbm-1.10.tar.gz'
  sha1 '441201e9145f590ba613f8a1e952455d620e0860'
  
  depends_on 'pkg-config' => :build
	
	ENV['CFLAGS'] = "-fPIC -shared  -static -rpath -ldl -rdynamic -Os -w -pipe -march=core2 -msse4"
	ENV['CXXFLAGS'] = "-fPIC -shared -static -rpath -ldl -rdynamic -Os -w -pipe -march=core2 -msse4"

  def install
    system "./configure", "--enable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--infodir=#{info}"
    system "make install"
  end
end
