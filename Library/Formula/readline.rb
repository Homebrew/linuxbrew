require 'formula'

class Readline < Formula
  homepage 'http://tiswww.case.edu/php/chet/readline/rltop.html'
  url 'http://ftpmirror.gnu.org/readline/readline-6.2.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/readline/readline-6.2.tar.gz'
  sha256 '79a696070a058c233c72dd6ac697021cc64abd5ed51e59db867d66d196a89381'
  version '6.2.4'

  depends_on 'pkg-config' => :build
  depends_on 'libtool'
  depends_on 'libconfig'
  depends_on 'libffi'
  
  def patches
    p1 = ['https://gist.github.com/anonymous/48566168e33e01066dbe#file-readline62-patch']
    p
  end
  
  def install
    #ENV.universal_binary
    system "./configure", "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--infodir=#{info}",
                          "--enable-multibyte"
    system "make"                     
    system "make install"
  end
end
