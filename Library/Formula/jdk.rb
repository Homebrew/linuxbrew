require "formula"

class JavaDownloadStrategy < CurlDownloadStrategy # get around license issue
  def _fetch
    curl @url, "-j", "-k", "-L", "-H", "Cookie: oraclelicense=accept-securebackup-cookie", '-o', temporary_path
  end
end

class Jdk < Formula
  homepage "http://www.java.com/"
  version "1.8.0-25"

  if OS.linux?
    url "http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-x64.tar.gz", :using => JavaDownloadStrategy
    sha1 "0eb0448641c21c435cddc4705d23668d45f29fff"
  elsif OS.mac?
    raise "On Mac OS try instead `brew cask install java`"
  else
    raise "Unknown operating system"
  end

  def install
    prefix.install Dir["*"]
  end

  test do
    system "#{bin}/java", "-version"
    system "#{bin}/javac", "-version"
  end
end
