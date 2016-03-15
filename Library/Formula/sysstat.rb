class Sysstat < Formula
  desc "Performance monitoring tools for Linux"
  homepage "https://github.com/sysstat/sysstat"
  url "https://github.com/sysstat/sysstat/archive/v11.3.2.tar.gz"
  sha256 "3f7b5f30c192846c99f5778f4e5cbe0216a35424dffbc19e7d7abaa9599df720"
  head "https://github.com/sysstat/sysstat.git"
  # tag "linuxbrew"

  def install
    system "./configure",
      "--disable-file-attr", # Fix install: cannot change ownership
      "--prefix=#{prefix}",
      "conf_dir=#{etc}/sysconfig",
      "sa_dir=#{var}/log/sa"
    system "make", "install"
  end

  test do
    system "#{bin}/sar", "-V"
  end
end
