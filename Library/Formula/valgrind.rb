require 'formula'

class Valgrind < Formula
  homepage 'http://www.valgrind.org/'
  url 'http://valgrind.org/downloads/valgrind-3.9.0.tar.bz2'
  sha1 '9415e28933de9d6687f993c4bb797e6bd49583f1'
  
  depends_on 'pkg-config' => :build
  depends_on :autoconf
  depends_on :automake
  depends_on :libtool

  # Valgrind needs vcpreload_core-*-darwin.so to have execute permissions.
  # See #2150 for more information.
  skip_clean 'lib/valgrind'

  def install
    args = %W[
      --enable-dependency-tracking
      --prefix=#{prefix}
    ]
    if MacOS.prefer_64_bit?
      args << "--enable-only64bit" << "--build=x86_64-linux"
    else
      args << "--enable-only32bit"
    end

    system "./configure", *args
    system 'make'
    system "make install"
  end

  def test
    system "#{bin}/valgrind", "ls", "-l"
  end
end
