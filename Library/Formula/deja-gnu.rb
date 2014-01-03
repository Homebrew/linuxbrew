require 'formula'

class DejaGnu < Formula
  homepage 'http://www.gnu.org/software/dejagnu/'
  url 'http://ftpmirror.gnu.org/dejagnu/dejagnu-1.5.1.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/dejagnu/dejagnu-1.5.1.tar.gz'
  sha1 'eb16fb455690592a97f22acd17e8fc2f1b5c54c2'

  head 'http://git.sv.gnu.org/r/dejagnu.git'

	depends_on 'pkg-config' => :build
	depends_on 'autoconf' => :build
	depends_on 'docbook'
	depends_on 'docbook2x'=> :build
	
  ENV['CFLAGS'] = "-fPIC -shared  -static -rpath -ldl -rdynamic -Os -w -pipe -march=core2 -msse4"
  ENV['CXXFLAGS'] = "-fPIC -shared -static -rpath -ldl -rdynamic -Os -w -pipe -march=core2 -msse4"
	
  def install
    ENV.j1 # Or fails on Mac Pro
		
		system "autoreconf", "-v", "-i", "-m"
    system "./configure", "--enable-debug", "--enable-dependency-tracking",
													"-with-docbook2x",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    # DejaGnu has no compiled code, so go directly to 'make check'
    system "make check"
    system "make install"
  end
end
