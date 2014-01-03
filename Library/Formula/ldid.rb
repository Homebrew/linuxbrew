
require 'formula'

class Ldid < Formula
  homepage ''
  url 'git://git.saurik.com/ldid.git', :tag => 'v1.1.2'

  def install
    system "sh make.sh"
    bin.install "ldid"
  end
end