require "formula"

class Cgdb < Formula
  homepage "https://cgdb.github.io/"
  url "http://cgdb.me/files/cgdb-0.6.8.tar.gz"
  sha1 "0892ae59358fa98264269cf6fe57928314ef7942"

  bottle do
    sha1 "ad041a0d959f9c78acbaf9e702028418f4fbaced" => :yosemite
    sha1 "49b22ef93ad50cc3189eab87c887aac4bf7d5be6" => :mavericks
    sha1 "4401a042175f6071740d1d87bb5993ebb3b76d2a" => :mountain_lion
  end

  head do
    url "https://github.com/cgdb/cgdb.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  if OS.linux?
    depends_on "flex" => :build
  end
  depends_on "help2man" => :build
  depends_on "readline"

  patch :DATA

  def install
    system "sh", "autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-readline=#{Formula['readline'].opt_prefix}"
    system "make install"
  end
end
__END__
--- a/configure	2014-11-13 19:59:03.000000000 +0000
+++ b/configure	2015-05-27 13:04:58.815408757 +0000
@@ -5443,7 +5443,7 @@ else
   ac_cv_prog_HAS_HELP2MAN="$HAS_HELP2MAN" # Let the user override the test.
 else
 as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
-for as_dir in path =$PATH
+for as_dir in $PATH
 do
   IFS=$as_save_IFS
   test -z "$as_dir" && as_dir=.
