# encoding: UTF-8

require 'formula'

class Bsdconv < Formula
  homepage 'https://github.com/buganini/bsdconv'
  url 'https://github.com/buganini/bsdconv/archive/11.1.tar.gz'
  sha1 'd2dd2e94fd013d2d7cfa4d55ebff0bd6a7c5c244'

  head 'https://github.com/buganini/bsdconv.git'
	
	depends_on 'pkg-config' => :build
	
  ENV['CFLAGS'] = "-fPIC -shared  -static -rpath -ldl -rdynamic -Os -w -pipe -march=core2 -msse4"
  ENV['CXXFLAGS'] = "-fPIC -shared -static -rpath -ldl -rdynamic -Os -w -pipe -march=core2 -msse4"
	
  def install
    system "make", "PREFIX=#{prefix}"
    system "make", "PREFIX=#{prefix}", "install"
	  system "chmod 0766 -v #{prefix}/lib/*"
  end

  test do
    require 'open3'
    Open3.popen3("#{bin}/bsdconv", "big5:utf-8") do |stdin, stdout, _|
      stdin.write("\263\134\245\134\273\134")
      stdin.close
      assert_equal "許功蓋", stdout.read
    end
  end
end
