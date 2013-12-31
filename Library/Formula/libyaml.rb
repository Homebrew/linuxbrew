require 'formula'

class Libyaml < Formula
  homepage 'http://pyyaml.org/wiki/LibYAML'
  url 'http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz'
  sha1 'e0e5e09192ab10a607e3da2970db492118f560f2'

  depends_on 'pkg-config' => :build
  depends_on 'libtool'
  depends_on 'gettext'
  depends_on 'libffi'
  
  option :universal

  def install
    ENV.universal_binary if build.universal?

    system "./configure", "--enable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
