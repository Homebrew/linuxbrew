module OS
  module X11
    extend self

    def installed?
      @installed ||= detect_installed
    end

    def detect_installed
      version ? true : false
    end

    def version
      @version ||= detect_version
    end

    def detect_version
      begin
        version_string = `xterma -version`
        version_string.match /\((\d+)\)/
      rescue Errno::ENOENT
      end
    end
  end
end
