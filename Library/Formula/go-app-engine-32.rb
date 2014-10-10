require "formula"

class GoAppEngine32 < Formula
  homepage "http://code.google.com/appengine/docs/go/overview.html"
  if OS.mac?
    url "https://storage.googleapis.com/appengine-sdks/featured/go_appengine_sdk_darwin_386-1.9.12.zip"
    sha1 "409be3d959edb9b00bfd637e37460bfc04b6ae94"
  elsif OS.linux?
    url "https://storage.googleapis.com/appengine-sdks/featured/go_appengine_sdk_linux_386-1.9.12.zip"
    sha1 "d1d5a11566f5f1522f4ba5485f5f4d26fa7b676a"
  else 
      raise "Unknown operating system"
  end  
  def install
    cd ".."
    share.install "go_appengine" => name
    %w[
      api_server.py appcfg.py bulkloader.py bulkload_client.py dev_appserver.py download_appstats.py goapp
    ].each do |fn|
      bin.install_symlink share/name/fn
    end
  end
end
