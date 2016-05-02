require "requirement"
require "requirements/x11_requirement"

class XorgRequirement < X11Requirement
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
    "X.Org is required to install this formula."
  end
end
