class Libfuse < Formula
  desc "Reference implementation of the Linux FUSE interface."
  homepage "https://github.com/libfuse/libfuse"
  url "https://github.com/libfuse/libfuse/archive/fuse_2_9_5.tar.gz"
  sha256 "ccea9c00f7572385e9064bc55b2bfefd8d34de487ba16d9eb09672202b5440ec"
  head "https://github.com/libfuse/libfuse.git"
  # tag "linuxbrew"

  def install
    system "./makeconf.sh"
    ENV["MOUNT_FUSE_PATH"] = "#{sbin}/"
    ENV["UDEV_RULES_PATH"] = "#{etc}/udev/rules.d"
    ENV["INIT_D_PATH"] = "#{etc}/init.d"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"fuse-test.c").write <<-EOS.undent
      #include <fuse.h>
      #include <stdlib.h>
      int main(int argc, char** argv)
      {
        struct fuse_operations ops = {NULL, };
        return fuse_main(argc, argv, &ops, NULL);
      }
    EOS
    system ENV["CC"], ENV["CPPFLAGS"], "-DFUSE_USE_VERSION=26",
           "-o", "fuse-test", "fuse-test.c", ENV["LDFLAGS"], "-lfuse"
  end
end
