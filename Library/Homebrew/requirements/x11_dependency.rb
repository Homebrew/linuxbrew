require 'requirement'
require 'extend/set'
require 'os/x11'

class X11Dependency < Requirement
  include Comparable
  attr_reader :min_version

  fatal true

  env { ENV.x11 }

  def initialize(name="x11", tags=[])
    @name = name
    @min_version = tags.shift if /(\d\.)+\d/ === tags.first
    super(tags)
  end

  satisfy :build_env => false do
    if OS.mac?
      OS.MacOS::XQuartz.installed? && (@min_version.nil? || @min_version <= MacOS::XQuartz.version)
    elsif OS.linux?
      OS::X11.installed? && (@min_version.nil? || @min_version <= OS::X11.version)
    else
      true
    end
  end

  def message
    if OS.mac?
      <<-EOS.undent
        Unsatisfied dependency: XQuartz #{@min_version}
        Homebrew does not package XQuartz. Installers may be found at:
          https://xquartz.macosforge.org
      EOS
    else
      <<-EOS.undent
        Unsatisfied dependency: X11 #{@min_version}
        Homebrew does not package X11.
        Consult your distribution's manual on how to install X11.
      EOS
    end
  end

  def <=> other
    return nil unless X11Dependency === other

    if min_version.nil? && other.min_version.nil?
      0
    elsif other.min_version.nil?
      1
    elsif min_version.nil?
      -1
    else
      min_version <=> other.min_version
    end
  end
end
