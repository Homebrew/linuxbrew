require 'formula'

class Bison < Formula
  homepage 'http://www.gnu.org/software/bison/'
  url 'http://ftpmirror.gnu.org/bison/bison-3.0.1.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/bison/bison-3.0.1.tar.gz'
  sha1 '0191d1679525b1e05bb35265a71e7475e7cb1432'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end
