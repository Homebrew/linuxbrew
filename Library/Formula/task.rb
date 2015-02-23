class Task < Formula
  homepage "http://www.taskwarrior.org/"
  url "http://www.taskwarrior.org/download/task-2.4.1.tar.gz"
  sha1 "4882628ac339e31fcb0fef2f4a1c585e86eb95c7"
  head "https://git.tasktools.org/scm/tm/task.git", :branch => "2.4.2", :shallow => false

  depends_on "cmake" => :build
  depends_on "gnutls" => :optional

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    bash_completion.install "scripts/bash/task.sh"
    zsh_completion.install "scripts/zsh/_task"
  end

  test do
    system "#{bin}/task", "--version"
  end
end
