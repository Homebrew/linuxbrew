require 'formula'

class Faac < Formula
  homepage 'http://www.audiocoding.com/faac.html'
  url 'https://downloads.sourceforge.net/project/faac/faac-src/faac-1.28/faac-1.28.tar.gz'
  sha1 'd00b023a3642f81bb1fb13d962a65079121396ee'

  bottle do
    cellar :any
    sha1 "923f62ca1292dcf930a4def01da662d5facf3b87" => :mavericks
    sha1 "aab2425c764152a2f4ea7eb99072153d1eed1654" => :mountain_lion
    sha1 "88bd2a82586156372015b7a884809a2d14d127cb" => :lion
  end

  patch :DATA

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end

__END__
diff -Naur faac-1.28-orig/common/mp4v2/mpeg4ip.h faac-1.28/common/mp4v2/mpeg4ip.h
--- faac-1.28-orig/common/mp4v2/mpeg4ip.h	2009-01-26 22:42:35.000000000 +0000
+++ faac-1.28/common/mp4v2/mpeg4ip.h	2009-08-04 13:45:47.728062591 +0100
@@ -120,14 +120,6 @@
 #endif
 #include <sys/param.h>

-#ifdef __cplusplus
-extern "C" {
-#endif
-char *strcasestr(const char *haystack, const char *needle);
-#ifdef __cplusplus
-}
-#endif
-
 #define OPEN_RDWR O_RDWR
 #define OPEN_CREAT O_CREAT
 #define OPEN_RDONLY O_RDONLY
