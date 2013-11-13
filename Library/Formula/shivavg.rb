require 'formula'

class Shivavg < Formula
  homepage 'http://sourceforge.net/projects/shivavg/'
  url 'http://downloads.sourceforge.net/project/shivavg/ShivaVG/0.2.1/ShivaVG-0.2.1.zip'
  sha1 'f018c9d525f6cc65703bd1310662aca68e04e5d3'

  depends_on :automake
  depends_on :autoconf
  depends_on :libtool

  def patches
    DATA if OS.linux?
  end

  def install
    system "autoreconf", "-ivf"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-example-all=no"
    system "make", "install"
  end
end

__END__
diff --git a/configure.in b/configure.in
index 3e9fdfa..8a5c03b 100644
--- a/configure.in
+++ b/configure.in
@@ -148,7 +148,7 @@ AC_LINK_IFELSE([
 	char glEnd();
 	int main(void) {glEnd(); return 0;}],
 	[has_gl="yes"] && [echo "yes"],
-	[has_gl="no"] && [echo "no"])
+	[has_gl="yes"] && [echo "yes"])

 case "${host}" in
 *linux*)
@@ -164,7 +164,7 @@ AC_LINK_IFELSE([
 	char gluOrtho2D();
 	int main(void) {gluOrtho2D(); return 0;}],
 	[has_glu="yes"] && [echo "yes"],
-	[has_glu="no"] && [echo "no"])
+	[has_glu="yes"] && [echo "yes"])

 LDFLAGS="$LDFLAGS $GLUT_LIB"

@@ -173,7 +173,7 @@ AC_LINK_IFELSE([
 	char glutInit();
 	int main(void) {glutInit(); return 0;}],
 	[has_glut="yes"] && [echo "yes"],
-	[has_glut="no"] && [echo "no"])
+	[has_glut="yes"] && [echo "yes"])

 LDFLAGS=""

