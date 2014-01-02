require 'formula'
require 'blacklist'

module Homebrew extend self

  # Create a formula from a tarball URL
  def create

    # Allow searching MacPorts or Fink.
    if ARGV.include? '--macports'
      exec_browser "http://www.macports.org/ports.php?by=name&substr=#{ARGV.next}"
    elsif ARGV.include? '--fink'
      exec_browser "http://pdb.finkproject.org/pdb/browse.php?summary=#{ARGV.next}"
    end

    raise UsageError if ARGV.named.empty?

    # Ensure that the cache exists so we can fetch the tarball
    HOMEBREW_CACHE.mkpath

    url = ARGV.named.first # Pull the first (and only) url from ARGV

    version = ARGV.next if ARGV.include? '--set-version'
    name = ARGV.next if ARGV.include? '--set-name'

    fc = FormulaCreator.new
    fc.name = name
    fc.version = version
    fc.url = url

    fc.mode = if ARGV.include? '--cmake'
      :cmake
    elsif ARGV.include? '--autotools'
      :autotools
    end

    if fc.name.nil? or fc.name.to_s.strip.empty?
      path = Pathname.new url
      print "Formula name [#{path.stem}]: "
      fc.name = __gets || path.stem
      fc.path = Formula.path fc.name
    end

    # Don't allow blacklisted formula, or names that shadow aliases,
    # unless --force is specified.
    unless ARGV.force?
      if msg = blacklisted?(fc.name)
        raise "#{fc.name} is blacklisted for creation.\n#{msg}\nIf you really want to create this formula use --force."
      end

      if Formula.aliases.include? fc.name
        realname = Formula.canonical_name fc.name
        raise <<-EOS.undent
          The formula #{realname} is already aliased to #{fc.name}
          Please check that you are not creating a duplicate.
          To force creation use --force.
          EOS
      end
    end

    fc.generate!

    puts "Please `brew audit #{fc.name}` before submitting, thanks."
    exec_editor fc.path
  end

  def __gets
    gots = $stdin.gets.chomp
    if gots.empty? then nil else gots end
  end
end

class FormulaCreator
  attr_reader :url, :sha1
  attr_accessor :name, :version, :path, :mode

  def url= url
    @url = url
    path = Pathname.new(url)
    if @name.nil?
      %r{github.com/\S+/(\S+)/archive/}.match url
      @name ||= $1
      /(.*?)[-_.]?#{path.version}/.match path.basename
      @name ||= $1
      @path = Formula.path @name unless @name.nil?
    else
      @path = Formula.path name
    end
    if @version
      @version = Version.new(@version)
    else
      @version = Pathname.new(url).version
    end
  end

  def generate!
    raise "#{path} already exists" if path.exist?

    require 'digest'
    require 'erb'

    if version.nil?
      opoo "Version cannot be determined from URL."
      puts "You'll need to add an explicit 'version' to the formula."
    end

    # XXX: why is "and version" here?
    unless ARGV.include? "--no-fetch" and version
      r = Resource.new
      r.url, r.version, r.owner = url, version, self
      @sha1 = r.fetch.sha1 if r.download_strategy == CurlDownloadStrategy
    end

    path.write ERB.new(template, nil, '>').result(binding)
  end

  def template; <<-EOS.undent
    require 'formula'

    # Create by Senny Chu,SPF
    class #{Formula.class_s name} < Formula
      homepage ''
      url '#{url}'
    <% unless version.nil? or version.detected_from_url? %>
      version '#{version}'
    <% end %>
      sha1 '#{sha1}'

      def install
        # ENV.j1  # if your formula's build system can't parallelize
        
        system "./configure", "--enable-debug",
                              "--enable-dependency-tracking",
                              "--enable-silent-rules",
                              "--prefix=\#{prefix}",
                              "--enabile-shared"
        system "make"
        system "make install"
      end

      test do
        system "\#{bin}/program", "--version"
        system "false"
      end
    end
    EOS
  end
end
