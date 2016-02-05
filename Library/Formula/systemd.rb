class Systemd < Formula
  desc "System and service manager"
  homepage "https://wiki.freedesktop.org/www/Software/systemd/"
  url "http://www.freedesktop.org/software/systemd/systemd-221.tar.xz"
  sha256 "085e088650afbfc688ccb13459aedb1fbc7c8810358605b076301f472d51cc4f"
  # tag "linuxbrew"

  depends_on "libcap"
  depends_on "XML::Parser" => :perl

  def install
    system "./configure",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--prefix=#{prefix}",
      "--with-rootprefix=#{prefix}",
      "--with-sysvinit-path=#{etc}/init.d",
      "--with-sysvrcnd-path=#{etc}/rc.d"
    system "make", "install"
  end

  test do
    system "#{bin}/systemd-path"
  end
end
