require 'formula'

class Automake113 < Formula
  homepage 'http://www.gnu.org/software/automake/'
  url 'http://ftpmirror.gnu.org/automake/automake-1.13.4.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/automake/automake-1.13.4.tar.gz'
  sha1 '627d9df65f2edc2c0e9e6aa270d1c2c068921a3a'

  depends_on 'autoconf' => :run

  keg_only "Gnu System provides (a rather old) Automake."

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"

    # Our aclocal must go first. See:
    # https://github.com/mxcl/homebrew/issues/10618
    (share/"aclocal/dirlist").write <<-EOS.undent
      #{HOMEBREW_PREFIX}/share/aclocal
      /usr/share/aclocal
    EOS
  end

  test do
    system "#{bin}/automake", "--version"
  end
end
