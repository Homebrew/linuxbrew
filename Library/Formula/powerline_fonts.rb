require 'formula'

class PowerlineFonts < Formula
  url 'git@github.com:powerline/fonts.git', :using => :git, :revision => "8aab61d375f15a86f0a51d326f2417df9c4a0e52"
  homepage 'http://powerline.readthedocs.org/en/latest/installation.html#fonts-installation'
  version "1.0.0"

  def install
    fonts = share+"fonts"
    fonts.install Dir['*']
  end
end
