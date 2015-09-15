class Cv < Formula
  desc "Coreutils Progress Viewer: Show progress for coreutils (formerly known as cv)"
  homepage "https://github.com/Xfennec/progress"
  url "https://github.com/Xfennec/progress/archive/v0.9.tar.gz"
  sha256 "63e1834ec114ccc1de3d11722131b5975e475bfd72711d457e21ddd7fd16b6bd"
  head "https://github.com/Xfennec/progress.git"

  bottle do
    cellar :any
    sha256 "ca3b822899bd8c370fb4049f9b68574ad3bc897495bd6bb985279b29c70c554c" => :yosemite
    sha256 "0ade55ecc626b9559aa842b190cebcef0791287b019502eff106abe53960a4c7" => :mavericks
    sha256 "849b187b69a23fbfad43121337a89c618426080571bc6d87e99b067a3dcfe4c7" => :mountain_lion
  end

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system "progress", "--help"
    pid = fork do
      system "/bin/dd", "if=/dev/zero", "of=/dev/null", "bs=100000", "count=1000000"
    end
    sleep 1
    begin
      assert_match /dd/, shell_output("progress")
    ensure
      Process.kill 9, pid
      Process.wait pid
    end
  end
end
