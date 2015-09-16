require "requirement"

class CmakeRequirement < Requirement
  fatal true
  default_formula "cmake"

  def initialize(tags)
    @version = tags.shift if /\d+\.*\d*/ === tags.first
    raise "Specify a version for CmakeRequirement" unless @version
    super
  end

  satisfy :build_env => false do
    next unless which "cmake"
    cmake_version = Utils.popen_read("cmake", "--version").split(" ").last
    Version.new(cmake_version) >= Version.new(@version)
  end

  env do
    ENV.prepend_path "PATH", which("cmake").dirname
  end

  def message
    s = "Cmake #{@version} or later is required."
    s += super
    s
  end

  def inspect
    "#<#{self.class.name}: #{name.inspect} #{tags.inspect} version=#{@version.inspect}>"
  end
end
