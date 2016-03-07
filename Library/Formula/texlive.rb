class Texlive < Formula
  desc "TeX Live is a free software distribution for the TeX typesetting system"
  homepage "http://www.tug.org/texlive/"
  # tag "linuxbrew"

  url "http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"
  version "20160306"
  sha256 "794f5f7fc889fe6e55b70cfb826b1b2b07196ad13e679813801048b337d6343f"

  option "with-full", "install everything"
  option "with-medium", "install small + more packages and languages"
  option "with-small", "install basic + xetex, metapost, a few languages [default]"
  option "with-basic", "install plain and latex"
  option "with-minimal", "install plain only"

  def install
    scheme = %w[full medium small basic minimal].find {
      |x| build.with? x
    } || "small"

    ohai "Downloading and installing TeX Live. This will take a few minutes."
    ENV["TEXLIVE_INSTALL_PREFIX"] = prefix
    system "./install-tl", "-scheme", scheme, "-portable", "-profile", "/dev/null"

    binarch = bin/"x86_64-linux"
    man1.install Dir[binarch/"man/man1/*"]
    man5.install Dir[binarch/"man/man5/*"]
    bin.install_symlink Dir[binarch/"*"]
  end

  test do
    system "#{bin}/tex", "--version"
  end
end
