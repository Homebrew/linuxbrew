class AndroidNdk < Formula
  desc "Android native-code language toolset"
  homepage "https://developer.android.com/sdk/ndk/index.html"
  version "r10e"
  if OS.mac?
    url "https://dl.google.com/android/repository/android-ndk-r11b-darwin-x86_64.zip"
    sha256 "3a2743fb357dc0948d17dc0696e4ab5cd724dc4bc1c36a40e797068fbfc9d976"
  elsif OS.linux?
    url "https://dl.google.com/android/ndk/android-ndk-#{version}-linux-x86_64.bin"
    sha256 "102d6723f67ff1384330d12c45854315d6452d6510286f4e5891e00a5a8f1d5a"
  end

  bottle :unneeded

  # As of r10e, only a 64-bit version is provided
  depends_on :arch => :x86_64
  depends_on "android-sdk" => :recommended

  conflicts_with "crystax-ndk",
    :because => "both install `ndk-build`, `ndk-gdb` and `ndk-stack` binaries"

  def install
    bin.mkpath

    # Now we can install both 64-bit and 32-bit targeting toolchains
    prefix.install Dir["*"]

    # Create a dummy script to launch the ndk apps
    ndk_exec = prefix+"ndk-exec.sh"
    ndk_exec.write <<-EOS.undent
      #!/bin/sh
      BASENAME=`basename $0`
      EXEC="#{prefix}/$BASENAME"
      test -f "$EXEC" && exec "$EXEC" "$@"
    EOS
    ndk_exec.chmod 0755
    %w[ndk-build ndk-depends ndk-gdb ndk-stack ndk-which].each { |app| bin.install_symlink ndk_exec => app }
  end

  def caveats; <<-EOS.undent
    We agreed to the Android NDK License Agreement for you by downloading the NDK.
    If this is unacceptable you should uninstall.

    License information at:
    https://developer.android.com/sdk/terms.html

    Software and System requirements at:
    https://developer.android.com/sdk/ndk/index.html#requirements

    For more documentation on Android NDK, please check:
      #{prefix}/docs
    EOS
  end
end
