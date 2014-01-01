require 'formula'

class Doxygen < Formula
  homepage 'http://www.doxygen.org/'
  url 'http://ftp.stack.nl/pub/users/dimitri/doxygen-1.8.5.src.tar.gz'
  mirror 'http://downloads.sourceforge.net/project/doxygen/rel-1.8.5/doxygen-1.8.5.src.tar.gz'
  sha1 '1fc5ceec21122fe5037edee4c308ac94b59ee33e'

  head 'https://doxygen.svn.sourceforge.net/svnroot/doxygen/trunk'

  option 'with-dot', 'Build with dot command support from Graphviz.'
  option 'with-doxywizard', 'Build GUI frontend with qt support.'
  option 'with-libclang', 'Build with libclang support.'

  depends_on 'graphviz' if build.with? 'dot'
  depends_on 'qt' if build.with? 'doxywizard'
  depends_on 'llvm' => 'with-clang' if build.with? 'libclang'

  ENV['CFLAGS'] = "-fPIC -shared  -static -rpath -ldl -rdynamic -Os -w -pipe -march=core2 -msse4"
  ENV['CXXFLAGS'] = "-fPIC -shared -static -rpath -ldl -rdynamic -Os -w -pipe -march=core2 -msse4"

  def install
    args = ["--prefix", prefix]
    args << '--with-libclang' if build.with? 'libclang'
    args << '--with-doxywizard' if build.with? 'doxywizard'
    system "./configure", *args

    system "make"
    # MAN1DIR, relative to the given prefix
    system "make", "MAN1DIR=share/man/man1", "install"
  end
end
