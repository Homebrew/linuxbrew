class Libxcb < Formula
  desc "Modern base X11 library"
  homepage "https://wiki.freedesktop.org/xcb/"
  url "http://xcb.freedesktop.org/dist/libxcb-1.11.1.tar.gz"
  sha256 "660312d5e64d0a5800262488042c1707a0261fa01a759bad265b1b75dd4844dd"
  head "git://anongit.freedesktop.org/git/xcb/libxcb"
  # tag "linuxbrew"

  depends_on "xproto"
  depends_on "libxau"
  depends_on "libxslt"
  depends_on "pkg-config" => :build
  depends_on :python

  resource "xcb-proto" do
    url "http://xcb.freedesktop.org/dist/xcb-proto-1.11.tar.gz"
    sha256 "d12152193bd71aabbdbb97b029717ae6d5d0477ab239614e3d6193cc0385d906"
  end

  resource "pthread-stubs" do
    url "http://www.x.org/releases/X11R7.7/src/xcb/libpthread-stubs-0.3.tar.gz"
    sha256 "3031f466cf0b06de6b3ccbf2019d15c4fcf75229b7d226a711bc1885b3a82cde"
  end

  def install
    %w[pthread-stubs xcb-proto].each do |r|
      resource(r).stage do
        system "./configure", "--prefix=#{buildpath}/#{r}"
        system "make", "install"
      end
    end

    ENV.append_path "PKG_CONFIG_PATH", "#{buildpath}/xcb-proto/lib/pkgconfig"
    ENV.append_path "PKG_CONFIG_PATH", "#{buildpath}/pthread-stubs/lib/pkgconfig"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <xcb/xcb.h>
      int main(int argc, char** argv)
      {
          xcb_connection_t* connection = xcb_connect(NULL, NULL);
          xcb_disconnect(connection);
          return 0;
      }
    EOS
    flags = (ENV.cflags || "").split << "-I#{include}" << "-L#{lib}" << "-lxcb"
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
