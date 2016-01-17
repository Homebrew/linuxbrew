class Nethogs < Formula
  desc "Net top tool grouping bandwidth per process"
  homepage "https://raboof.github.io/nethogs/"
  url "https://github.com/raboof/nethogs/archive/v0.8.1.tar.gz"
  sha256 "4c30ef43814549974a5b01fb1a94eb72ff08628c5a421085b1ce3bfe0524df42"

  depends_on "homebrew/dupes/libpcap"
  depends_on "homebrew/dupes/ncurses"

  def install
    inreplace "Makefile", "prefix := /usr/local", "prefix := #{prefix}"
    inreplace "Makefile", "$(CC) $(CFLAGS)", "$(CC) $(CFLAGS) $(CPPFLAGS)"
    inreplace "Makefile", "$(CXX) $(CXXFLAGS)", "$(CXX) $(CXXFLAGS) $(CPPFLAGS)"
    system "make", "install"
  end

  test do
    system "nethogs", "-V" # Using -V because other nethogs commands need to be run as root
  end
end
