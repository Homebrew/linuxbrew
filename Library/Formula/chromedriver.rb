class Chromedriver < Formula
  desc "Tool for automated testing of webapps across many browsers"
  homepage "https://sites.google.com/a/chromium.org/chromedriver/"
  baseurl = "https://chromedriver.storage.googleapis.com/2.21/chromedriver_"
  if OS.mac?
    url "#{baseurl}mac32.zip"
    sha256 "41f21005b498adc5896e4c3e264d718e4ade09609a7544ea8753d4e8ef1e787f"
  elsif MacOS.prefer_64_bit?
    url "#{baseurl}linux64.zip"
    sha256 "8f0b879391e776e6741c8dc5016e7010c528c2007333c5220ad54dcc25de1cba"
  else
    url "#{baseurl}linux32.zip"
    sha256 "1fbc3e4a7ff35d03d67be4a8a8dbd9b1b035fcc6a9b06fb18d466b710af89242"
  end
  version "2.21"

  bottle :unneeded

  def install
    bin.install "chromedriver"
  end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>homebrew.mxcl.chromedriver</string>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <false/>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/chromedriver</string>
      </array>
      <key>ServiceDescription</key>
      <string>Chrome Driver</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/chromedriver-error.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/chromedriver-output.log</string>
    </dict>
    </plist>
    EOS
  end

  test do
    driver = fork do
      exec bin/"chromedriver",
             "--port=9999", "--log-path=#{testpath}/cd.log"
    end
    sleep 5
    Process.kill("TERM", driver)
    File.exist? testpath/"cd.log"
  end
end
