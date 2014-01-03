require 'formula'

class Ruby < Formula
  homepage 'https://www.ruby-lang.org/'
  url 'http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p353.tar.bz2'
  sha256 '3de4e4d9aff4682fa4f8ed2b70bd0d746fae17452fc3d3a8e8f505ead9105ad9'

  option 'with-suffix', 'Suffix commands with "20"'
  option 'with-doc', 'Install documentation'

  depends_on 'pkg-config' => :build
  depends_on 'readline' => :recommended
  depends_on 'gdbm' => :optional
  depends_on 'libyaml'
  depends_on 'libffi' => :recommended
  depends_on 'openssl' => :recommended

  def install
    args = %W[--prefix=#{prefix} --enable-shared --enable-rpath --enable-pthread]
    args << "--program-suffix=20" if build.with? "suffix"
    args << "--with-out-ext=tk"
    args << "--enable-install-doc" if build.with? "doc"
    args << "--disable-dtrace"

    # Put gem, site and vendor folders in the HOMEBREW_PREFIX
    ruby_lib = HOMEBREW_PREFIX/"lib/ruby"
    (ruby_lib/'site_ruby').mkpath
    (ruby_lib/'vendor_ruby').mkpath
    (ruby_lib/'gems').mkpath

    (lib/'ruby').install_symlink ruby_lib/'site_ruby',
                                 ruby_lib/'vendor_ruby',
                                 ruby_lib/'gems'

    system "./configure", *args
    system "make"
    system "make install"
  end

  def caveats; <<-EOS.undent
    By default, gem installed executables will be placed into:
      #{opt_prefix}/bin

    You may want to add this to your PATH. After upgrades, you can run
      gem pristine --all --only-executables

    to restore binstubs for installed gems.
    EOS
  end
end
