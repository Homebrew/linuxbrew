class Libxau < Formula
  desc "Library for handling .XAuthority files"
  homepage "http://www.x.org"
  url "http://ftp.x.org/pub/individual/lib/libXau-1.0.8.tar.gz"
  sha256 "c343b4ef66d66a6b3e0e27aa46b37ad5cab0f11a5c565eafb4a1c7590bc71d7b"
  # tag "linuxbrew"

  depends_on "pkg-config" => :build
  depends_on "xproto"

  resource "xorg-macros" do
    url "http://xorg.freedesktop.org/releases/individual/util/util-macros-1.19.0.tar.bz2"
    sha256 "2835b11829ee634e19fa56517b4cfc52ef39acea0cd82e15f68096e27cbed0ba"
  end

  def install
    resource("xorg-macros").stage do
      system "./configure", "--prefix=#{buildpath}/xorg-macros"
      system "make", "install"
    end

    ENV.append_path "PKG_CONFIG_PATH", "#{buildpath}/xorg-macros/share/pkgconfig"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <X11/Xauth.h>
      #include <stdio.h>
      int main(int argc, char** argv)
      {
          puts(XauFileName());
          return 0;
      }
    EOS
    flags = (ENV.cflags || "").split << "-I#{include}" << "-L#{lib}" << "-lXau"
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
