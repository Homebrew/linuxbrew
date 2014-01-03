require 'formula'

class Ant < Formula
  homepage 'http://ant.apache.org/'
  url 'http://www.apache.org/dyn/closer.cgi?path=ant/binaries/apache-ant-1.9.2-bin.tar.gz'
  mirror 'file:///home7/tvctopin/public_html/dev/ant-1.9.2-bin.tar.gz'
  sha1 '9985bafe4af3f6cde5fe7c824b2c1ec65f25347c'

 # keg_only :provided_by_osx if MacOS.version < :mavericks

  def install
    rm Dir['bin/*.{bat,cmd,dll,exe}']
    libexec.install Dir['*']
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "#{bin}/ant", "-version"
  end
end
