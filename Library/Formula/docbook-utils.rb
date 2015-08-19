class DocbookUtils < Formula
  desc "Tools for working on and format DocBook documents."
  homepage "https://www.sourceware.org/docbook-tools/"
  url "ftp://sources.redhat.com/pub/docbook-tools/new-trials/SOURCES/docbook-utils-0.6.14.tar.gz"
  sha256 "48faab8ee8a7605c9342fb7b906e0815e3cee84a489182af38e8f7c0df2e92e9"

  depends_on "docbook"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--mandir=#{man}",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "jw", "--version"
  end
end
