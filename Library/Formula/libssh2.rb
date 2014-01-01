require 'formula'

class Libssh2 < Formula
  homepage 'http://www.libssh2.org/'
  url 'http://www.libssh2.org/download/libssh2-1.4.3.tar.gz'
  sha1 'c27ca83e1ffeeac03be98b6eef54448701e044b0'

  ENV['CFLAGS'] = "-fPIC -shared  -static -rpath -ldl -rdynamic -Os -w -pipe -march=core2 -msse4"
  ENV['CXXFLAGS'] = "-fPIC -shared -static -rpath -ldl -rdynamic -Os -w -pipe -march=core2 -msse4"
	
	depends_on 'libgcrypt' => :build
	depends_on 'openssh'
	depends_on 'openssl'
	
  def install
    system "./configure", "--prefix=#{prefix}",
                          "--enable-debug",
                          "--enable-dependency-tracking",
                          "--with-openssl",
                          "--with-libz"
    system "make install"
  end
end
