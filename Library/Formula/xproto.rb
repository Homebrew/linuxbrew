class Xproto < Formula
  desc "X11 Protocol library"
  homepage "http://www.x.org"
  url "http://www.x.org/releases/X11R7.7/src/proto/xproto-7.0.23.tar.gz"
  sha256 "07efb40fdd23943ec554920eaf1fe175f70d20127c7a0ee8ab818bd88226f696"
  # tag "linuxbrew"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <X11/X.h>
      int main(int argc, char** argv)
      {
          int xVersion = X_PROTOCOL;
          return xVersion == 11 ? 0 : 1;
      }
    EOS
    flags = (ENV.cflags || "").split << "-I#{include}"
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
