class Swift < Formula
  desc "High-performance system programming language"
  homepage "https://github.com/apple/swift"

  stable do
    url "https://github.com/apple/swift/archive/swift-2.2-RELEASE.tar.gz"
    sha256 "6dfb9de14201b9804974b1f221573cfb3e24fd657ec3bf132bf3c75de02565f5"

    swift_tag = "swift-#{version}-RELEASE"
    resource "cmark" do
      url "https://github.com/apple/swift-cmark/archive/#{swift_tag}.tar.gz"
      sha256 "09c8da18c37f32cd0eb82b252a172481f5403c1bc6ab5740f92e87f8d1e79991"
    end

    resource "clang" do
      url "https://github.com/apple/swift-clang/archive/#{swift_tag}.tar.gz"
      sha256 "ba9220e61971a55d13f501dc30f452a5c272e4d897b444a5220f2e23dbbfc2f8"
    end

    resource "llvm" do
      url "https://github.com/apple/swift-llvm/archive/#{swift_tag}.tar.gz"
      sha256 "b975b816773aa9d888a9139f51acd1b57fd58959bb391f8f65645a2f9b6d4cc4"
    end
  end

  bottle do
    sha256 "c0b8bed3990381cda9d84142f1eac4ef4f378d20e88e59fb7c0878bce0e89bab" => :el_capitan
    sha256 "ebb1b44f3fb466deec1e7b5b198a4ec31388e47fc8e452124e2ae65d7c03884f" => :yosemite
    sha256 "bd1fecb956b0b92020e6964f62783e20cb272b384bd1a5c736d04ea811b1d10a" => :x86_64_linux
  end

  head do
    url "https://github.com/apple/swift.git"

    resource "cmark" do
      url "https://github.com/apple/swift-cmark.git"
    end

    resource "clang" do
      url "https://github.com/apple/swift-clang.git", :branch => "stable"
    end

    resource "llvm" do
      url "https://github.com/apple/swift-llvm.git", :branch => "stable"
    end
  end

  keg_only :provided_by_osx, "Apple's CLT package contains Swift."

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on :xcode => ["7.0", :build]
  depends_on "icu4c" unless OS.mac?
  depends_on "llvm" => ["with-clang", :build] unless OS.mac?

  # According to the official llvm readme, GCC 4.7+ is required
  fails_with :gcc_4_0
  fails_with :gcc
  ("4.3".."4.6").each do |n|
    fails_with :gcc => n
  end

  def install
    workspace = buildpath.parent
    build = workspace/"build"

    ln_sf buildpath, "#{workspace}/swift"
    resources.each { |r| r.stage("#{workspace}/#{r.name}") }

    mkdir build do
      system "#{buildpath}/utils/build-script",
        "-R",
        "--build-subdir=",
        "--no-llvm-assertions",
        "--no-swift-assertions",
        "--no-swift-stdlib-assertions",
        "--",
        "--workspace=#{workspace}",
        "--build-args=-j#{ENV.make_jobs}",
        "--lldb-use-system-debugserver",
        "--install-prefix=#{prefix}",
        ("--darwin-deployment-version-osx=#{MacOS.version}" if OS.mac?),
        "--build-jobs=#{ENV.make_jobs}"
    end
    os = OS.mac? ? "macosx" : OS::NAME
    bin.install "#{build}/swift-#{os}-x86_64/bin/swift",
                "#{build}/swift-#{os}-x86_64/bin/swift-autolink-extract",
                "#{build}/swift-#{os}-x86_64/bin/swift-compress",
                "#{build}/swift-#{os}-x86_64/bin/swift-demangle",
                "#{build}/swift-#{os}-x86_64/bin/swift-ide-test",
                "#{build}/swift-#{os}-x86_64/bin/swift-llvm-opt",
                "#{build}/swift-#{os}-x86_64/bin/swiftc",
                "#{build}/swift-#{os}-x86_64/bin/sil-extract",
                "#{build}/swift-#{os}-x86_64/bin/sil-opt"
    (lib/"swift").install "#{build}/swift-#{os}-x86_64/lib/swift/#{os}/",
                          "#{build}/swift-#{os}-x86_64/lib/swift/shims/"
  end

  test do
    (testpath/"test.swift").write 'print("test")'
    system "#{bin}/swiftc", "test.swift"
    assert_equal "test\n", shell_output("./test")
  end
end
