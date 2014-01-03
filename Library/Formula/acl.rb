require 'formula'

class Acl < Formula
  homepage 'http://www.linuxfromscratch.org/blfs/view/svn/postlfs/acl.html'
  url 'http://download.savannah.gnu.org/releases/acl/acl-2.2.52.src.tar.gz'
  sha1 '537dddc0ee7b6aa67960a3de2d36f1e2ff2059d9'

  depends_on 'pkg-config' => :build
  depends_on 'attr'
  
  
  def install
    system "./configure", "--enable-debug",
                          "--enable-dependency-tracking",
                          "--disable-static",
                          "--prefix=#{prefix}"

    system "make"
    system "make install install-dev install-lib"
  end
end
