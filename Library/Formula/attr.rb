require 'formula'

class Attr < Formula
  homepage 'http://www.linuxfromscratch.org/blfs/view/svn/postlfs/attr.html'
  url 'http://download.savannah.gnu.org/releases/attr/attr-2.4.47.src.tar.gz'
  sha1 '5060f0062baee6439f41a433325b8b3671f8d2d8'
  
  depends_on 'pkg-config' => :build
  
  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install install-dev install-lib"
  end
end
