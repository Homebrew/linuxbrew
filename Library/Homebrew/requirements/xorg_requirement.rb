require "requirement"

class XorgRequirement < Requirement
  fatal true
  default_formula "linuxbrew/xorg/xorg"

  env { ENV.x11 }

  def initialize(name = "xorg", tags = [])
    @name = name
    super(tags)
  end

  satisfy :build_env => false do
    Formula["linuxbrew/xorg/xorg"].installed?
  end

  def message
    s = "X.Org is required to install this formula."
    s += super
    s
  end
end
