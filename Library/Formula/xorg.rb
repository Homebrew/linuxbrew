class Xorg < Formula
  desc "Xorg Libraries"
  homepage "http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html"
  version "7"

  url "http://ftp.x.org/pub/individual/lib/libFS-1.0.7.tar.bz2"
  sha256 "2e9d4c07026a7401d4fa4ffae86e6ac7fec83f50f3268fa85f52718e479dc4f3"
  # tag "linuxbrew"

  option "with-docs", "Build additional PDF or text documentation for the libXfont"
  option "with-doxygen", "Generate API documentation (for libxcb)"
  option "with-check-libxcb", "Run tests (for libxcb)"
  option "with-check-xcbproto", "Run tests (for xcb-proto)"

# Xorg: required dependencies
  depends_on "fontconfig"
# depends_on "libxcb"      # built as a resource here

# Xorg: optional dependencies
  if build.with?("docs") 
    depends_on "xmlto"
    depends_on "fop"        =>  :optional # needs update to 2.1
    depends_on "Links"      =>  :optional
    depends_on "lynx"       =>  :optional
    depends_on "w3m"        =>  :optional
  end

# libxcb: required dependencies
# depends_on "libXau"      # built as a resource here
# depends_on "xcbproto"    # built as a resource here

# libxcb: optional dependencies
  depends_on "doxygen"    =>  :optional if build.with?("doxygen") # to build API docs
  depends_on "check"      =>  :optional if build.with?("check-libxcb") # to run tests
  depends_on "libxslt"    =>  :optional # no explanation given


# xcbproto: required dependencies
  depends_on :python          # 
  depends_on "libxml2"    =>  :optional if build.with?("check-xcbproto") # to run tests
 #depends_on "libXdmcp"   => [:optional, :recommended] # built as a resource here
  depends_on "pkg-config" => :build

  depends_on "gettext"    => :build
##################################

  ### PROTO
  
  resource "util-macros" do
    url "http://www.x.org/archive/individual/util/util-macros-1.19.0.tar.bz2"
    sha256 "2835b11829ee634e19fa56517b4cfc52ef39acea0cd82e15f68096e27cbed0ba"
  end

  ##### XORG PROTOCOL HEADERS

  resource "bigreqsproto" do
    url      "http://ftp.x.org/pub/individual/proto/bigreqsproto-1.1.2.tar.bz2"
    sha256   "462116ab44e41d8121bfde947321950370b285a5316612b8fce8334d50751b1e"
  end

  resource "compositeproto" do
    url      "http://ftp.x.org/pub/individual/proto/compositeproto-0.4.2.tar.bz2"
    sha256   "049359f0be0b2b984a8149c966dd04e8c58e6eade2a4a309cf1126635ccd0cfc"
  end

  resource "damageproto" do
    url      "http://ftp.x.org/pub/individual/proto/damageproto-1.2.1.tar.bz2"
    sha256   "5c7c112e9b9ea8a9d5b019e5f17d481ae20f766cb7a4648360e7c1b46fc9fc5b"
  end

  resource "dmxproto" do
    url      "http://ftp.x.org/pub/individual/proto/dmxproto-2.3.1.tar.bz2"
    sha256   "e72051e6a3e06b236d19eed56368117b745ca1e1a27bdc50fd51aa375bea6509"
  end

  resource "dri2proto" do
    url      "http://ftp.x.org/pub/individual/proto/dri2proto-2.8.tar.bz2"
    sha256   "f9b55476def44fc7c459b2537d17dbc731e36ed5d416af7ca0b1e2e676f8aa04"
  end

  resource "dri3proto" do
    url      "http://ftp.x.org/pub/individual/proto/dri3proto-1.0.tar.bz2"
    sha256   "01be49d70200518b9a6b297131f6cc71f4ea2de17436896af153226a774fc074"
  end

  resource "fixesproto" do
    url      "http://ftp.x.org/pub/individual/proto/fixesproto-5.0.tar.bz2"
    sha256   "ba2f3f31246bdd3f2a0acf8bd3b09ba99cab965c7fb2c2c92b7dc72870e424ce"
  end

  resource "fontsproto" do
    url      "http://ftp.x.org/pub/individual/proto/fontsproto-2.1.3.tar.bz2"
    sha256   "259046b0dd9130825c4a4c479ba3591d6d0f17a33f54e294b56478729a6e5ab8"
  end

  resource "glproto" do
    url      "http://ftp.x.org/pub/individual/proto/glproto-1.4.17.tar.bz2"
    sha256   "adaa94bded310a2bfcbb9deb4d751d965fcfe6fb3a2f6d242e2df2d6589dbe40"
  end

  resource "inputproto" do
    url      "http://ftp.x.org/pub/individual/proto/inputproto-2.3.1.tar.bz2"
    sha256   "5a47ee62053a6acef3a83f506312494be1461068d0b9269d818839703b95c1d1"
  end

  resource "kbproto" do
    url      "http://ftp.x.org/pub/individual/proto/kbproto-1.0.7.tar.bz2"
    sha256   "f882210b76376e3fa006b11dbd890e56ec0942bc56e65d1249ff4af86f90b857"
  end

  resource "presentproto" do
    url      "http://ftp.x.org/pub/individual/proto/presentproto-1.0.tar.bz2"
    sha256   "812c7d48721f909a0f7a2cb1e91f6eead76159a36c4712f4579ca587552839ce"
  end

  resource "randrproto" do
    url      "http://ftp.x.org/pub/individual/proto/randrproto-1.5.0.tar.bz2"
    sha256   "4c675533e79cd730997d232c8894b6692174dce58d3e207021b8f860be498468"
  end

  resource "recordproto" do
    url      "http://ftp.x.org/pub/individual/proto/recordproto-1.14.2.tar.bz2"
    sha256   "a777548d2e92aa259f1528de3c4a36d15e07a4650d0976573a8e2ff5437e7370"
  end

  resource "renderproto" do
    url      "http://ftp.x.org/pub/individual/proto/renderproto-0.11.1.tar.bz2"
    sha256   "06735a5b92b20759204e4751ecd6064a2ad8a6246bb65b3078b862a00def2537"
  end

  resource "resourceproto" do
    url      "http://ftp.x.org/pub/individual/proto/resourceproto-1.2.0.tar.bz2"
    sha256   "3c66003a6bdeb0f70932a9ed3cf57cc554234154378d301e0c5cfa189d8f6818"
  end

  resource "scrnsaverproto" do
    url      "http://ftp.x.org/pub/individual/proto/scrnsaverproto-1.2.2.tar.bz2"
    sha256   "8bb70a8da164930cceaeb4c74180291660533ad3cc45377b30a795d1b85bcd65"
  end

  resource "videoproto" do
    url      "http://ftp.x.org/pub/individual/proto/videoproto-2.3.2.tar.bz2"
    sha256   "8dae168cb820fcd32f564879afb3f24d27c176300d9af66819a18265539bd4b6"
  end

  resource "xcmiscproto" do
    url      "http://ftp.x.org/pub/individual/proto/xcmiscproto-1.2.2.tar.bz2"
    sha256   "b13236869372256c36db79ae39d54214172677fb79e9cdc555dceec80bd9d2df"
  end

  resource "xextproto" do
    url      "http://ftp.x.org/pub/individual/proto/xextproto-7.3.0.tar.bz2"
    sha256   "f3f4b23ac8db9c3a9e0d8edb591713f3d70ef9c3b175970dd8823dfc92aa5bb0"
  end

  resource "xf86bigfontproto" do
    url      "http://ftp.x.org/pub/individual/proto/xf86bigfontproto-1.2.0.tar.bz2"
    sha256   "ba9220e2c4475f5ed2ddaa7287426b30089e4d29bd58d35fad57ba5ea43e1648"
  end

  resource "xf86dgaproto" do
    url      "http://ftp.x.org/pub/individual/proto/xf86dgaproto-2.1.tar.bz2"
    sha256   "ac5ef65108e1f2146286e53080975683dae49fc94680042e04bd1e2010e99050"
  end

  resource "xf86driproto" do
    url      "http://ftp.x.org/pub/individual/proto/xf86driproto-2.1.1.tar.bz2"
    sha256   "9c4b8d7221cb6dc4309269ccc008a22753698ae9245a398a59df35f1404d661f"
  end

  resource "xf86vidmodeproto" do
    url      "http://ftp.x.org/pub/individual/proto/xf86vidmodeproto-2.3.1.tar.bz2"
    sha256   "45d9499aa7b73203fd6b3505b0259624afed5c16b941bd04fcf123e5de698770"
  end

  resource "xineramaproto" do
    url      "http://ftp.x.org/pub/individual/proto/xineramaproto-1.2.1.tar.bz2"
    sha256   "977574bb3dc192ecd9c55f59f991ec1dff340be3e31392c95deff423da52485b"
  end

  resource "xproto" do
    url      "http://ftp.x.org/pub/individual/proto/xproto-7.0.28.tar.bz2"
    sha256   "29e85568d1f68ceef8a2c081dad9bc0e5500a53cfffde24b564dc43d46ddf6ca"
  end

  ##### END of XPROTOCOL HEADERS 

  resource "xcb-proto" do
    url "http://xcb.freedesktop.org/dist/xcb-proto-1.11.tar.gz"
    sha256 "d12152193bd71aabbdbb97b029717ae6d5d0477ab239614e3d6193cc0385d906"
  end

## for libxcb... see inreplace
# resource "libpthread-stubs" do
#   url "http://www.x.org/releases/X11R7.7/src/xcb/libpthread-stubs-0.3.tar.gz"
#   sha256 "3031f466cf0b06de6b3ccbf2019d15c4fcf75229b7d226a711bc1885b3a82cde"
# end


  resource "libXau" do
    url "http://ftp.x.org/pub/individual/lib/libXau-1.0.8.tar.gz"
    sha256 "c343b4ef66d66a6b3e0e27aa46b37ad5cab0f11a5c565eafb4a1c7590bc71d7b"
  end

  # recommended for libxcb
  resource "libXdmcp" do
    url "http://ftp.x.org/pub/individual/lib/libXdmcp-1.1.2.tar.bz2"
    sha256 "81fe09867918fff258296e1e1e159f0dc639cb30d201c53519f25ab73af4e4e2"
  end

  ### libxcb requires: xcb-proto and libXau
  resource "libxcb" do
    url "http://xcb.freedesktop.org/dist/libxcb-1.11.1.tar.gz"
    sha256 "660312d5e64d0a5800262488042c1707a0261fa01a759bad265b1b75dd4844dd"
  end

  resource "libFS" do
    url      "http://ftp.x.org/pub/individual/lib/libFS-1.0.7.tar.bz2"
    sha256   "2e9d4c07026a7401d4fa4ffae86e6ac7fec83f50f3268fa85f52718e479dc4f3"
  end

  resource "libICE" do
    url      "http://ftp.x.org/pub/individual/lib/libICE-1.0.9.tar.bz2"
    sha256   "8f7032f2c1c64352b5423f6b48a8ebdc339cc63064af34d66a6c9aa79759e202"
  end

  resource "libSM" do
    url      "http://ftp.x.org/pub/individual/lib/libSM-1.2.2.tar.bz2"
    sha256   "0baca8c9f5d934450a70896c4ad38d06475521255ca63b717a6510fdb6e287bd"
  end

  resource "libX11" do
    url      "http://ftp.x.org/pub/individual/lib/libX11-1.6.3.tar.bz2"
    sha256   "cf31a7c39f2f52e8ebd0db95640384e63451f9b014eed2bb7f5de03e8adc8111"
  end

  resource "libXScrnSaver" do
    url      "http://ftp.x.org/pub/individual/lib/libXScrnSaver-1.2.2.tar.bz2"
    sha256   "8ff1efa7341c7f34bcf9b17c89648d6325ddaae22e3904e091794e0b4426ce1d"
  end

  resource "libXaw" do
    url      "http://ftp.x.org/pub/individual/lib/libXaw-1.0.13.tar.bz2"
    sha256   "8ef8067312571292ccc2bbe94c41109dcf022ea5a4ec71656a83d8cce9edb0cd"
  end

  resource "libXcomposite" do
    url      "http://ftp.x.org/pub/individual/lib/libXcomposite-0.4.4.tar.bz2"
    sha256   "ede250cd207d8bee4a338265c3007d7a68d5aca791b6ac41af18e9a2aeb34178"
  end

  resource "libXcursor" do
    url      "http://ftp.x.org/pub/individual/lib/libXcursor-1.1.14.tar.bz2"
    sha256   "9bc6acb21ca14da51bda5bc912c8955bc6e5e433f0ab00c5e8bef842596c33df"
  end

  resource "libXdamage" do
    url      "http://ftp.x.org/pub/individual/lib/libXdamage-1.1.4.tar.bz2"
    sha256   "7c3fe7c657e83547f4822bfde30a90d84524efb56365448768409b77f05355ad"
  end

  resource "libXext" do
    url      "http://ftp.x.org/pub/individual/lib/libXext-1.3.3.tar.bz2"
    sha256   "b518d4d332231f313371fdefac59e3776f4f0823bcb23cf7c7305bfb57b16e35"
  end

  resource "libXfixes" do
    url      "http://ftp.x.org/pub/individual/lib/libXfixes-5.0.1.tar.bz2"
    sha256   "63bec085084fa3caaee5180490dd871f1eb2020ba9e9b39a30f93693ffc34767"
  end

  resource "libXfont" do
    url      "http://ftp.x.org/pub/individual/lib/libXfont-1.5.1.tar.bz2"
    sha256   "b70898527c73f9758f551bbab612af611b8a0962202829568d94f3edf4d86098"
  end

  resource "libXft" do
    url      "http://ftp.x.org/pub/individual/lib/libXft-2.3.2.tar.bz2"
    sha256   "f5a3c824761df351ca91827ac221090943ef28b248573486050de89f4bfcdc4c"
  end

  resource "libXi" do
    url      "http://ftp.x.org/pub/individual/lib/libXi-1.7.6.tar.bz2"
    sha256   "1f32a552cec0f056c0260bdb32e853cec0673d2f40646ce932ad5a9f0205b7ac"
  end

  resource "libXinerama" do
    url      "http://ftp.x.org/pub/individual/lib/libXinerama-1.1.3.tar.bz2"
    sha256   "7a45699f1773095a3f821e491cbd5e10c887c5a5fce5d8d3fced15c2ff7698e2"
  end

  resource "libXmu" do
    url      "http://ftp.x.org/pub/individual/lib/libXmu-1.1.2.tar.bz2"
    sha256   "756edc7c383254eef8b4e1b733c3bf1dc061b523c9f9833ac7058378b8349d0b"
  end

  resource "libXpm" do
    url      "http://ftp.x.org/pub/individual/lib/libXpm-3.5.11.tar.bz2"
    sha256   "c5bdafa51d1ae30086fac01ab83be8d47fe117b238d3437f8e965434090e041c"
  end

  resource "libXrandr" do
    url      "http://ftp.x.org/pub/individual/lib/libXrandr-1.5.0.tar.bz2"
    sha256   "6f864959b7fc35db11754b270d71106ef5b5cf363426aa58589cb8ac8266de58"
  end

  resource "libXrender" do
    url      "http://ftp.x.org/pub/individual/lib/libXrender-0.9.9.tar.bz2"
    sha256   "fc2fe57980a14092426dffcd1f2d9de0987b9d40adea663bd70d6342c0e9be1a"
  end

  resource "libXres" do
    url      "http://ftp.x.org/pub/individual/lib/libXres-1.0.7.tar.bz2"
    sha256   "26899054aa87f81b17becc68e8645b240f140464cf90c42616ebb263ec5fa0e5"
  end

  resource "libXt" do
    url      "http://ftp.x.org/pub/individual/lib/libXt-1.1.5.tar.bz2"
    sha256   "46eeb6be780211fdd98c5109286618f6707712235fdd19df4ce1e6954f349f1a"
  end

  resource "libXtst" do
    url      "http://ftp.x.org/pub/individual/lib/libXtst-1.2.2.tar.bz2"
    sha256   "ef0a7ffd577e5f1a25b1663b375679529663a1880151beaa73e9186c8309f6d9"
  end

  resource "libXv" do
    url      "http://ftp.x.org/pub/individual/lib/libXv-1.0.10.tar.bz2"
    sha256   "55fe92f8686ce8612e2c1bfaf58c057715534419da700bda8d517b1d97914525"
  end

  resource "libXvMC" do
    url      "http://ftp.x.org/pub/individual/lib/libXvMC-1.0.9.tar.bz2"
    sha256   "0703d7dff6ffc184f1735ca5d4eb9dbb402b522e08e008f2f96aee16c40a5756"
  end

  resource "libXxf86dga" do
    url      "http://ftp.x.org/pub/individual/lib/libXxf86dga-1.1.4.tar.bz2"
    sha256   "8eecd4b6c1df9a3704c04733c2f4fa93ef469b55028af5510b25818e2456c77e"
  end

  resource "libXxf86vm" do
    url      "http://ftp.x.org/pub/individual/lib/libXxf86vm-1.1.4.tar.bz2"
    sha256   "afee27f93c5f31c0ad582852c0fb36d50e4de7cd585fcf655e278a633d85cd57"
  end

  resource "libdmx" do
    url      "http://ftp.x.org/pub/individual/lib/libdmx-1.1.3.tar.bz2"
    sha256   "c97da36d2e56a2d7b6e4f896241785acc95e97eb9557465fd66ba2a155a7b201"
  end

  resource "libfontenc" do
    url      "http://ftp.x.org/pub/individual/lib/libfontenc-1.1.3.tar.bz2"
    sha256   "70588930e6fc9542ff38e0884778fbc6e6febf21adbab92fd8f524fe60aefd21"
  end

  resource "libpciaccess" do
    url      "http://ftp.x.org/pub/individual/lib/libpciaccess-0.13.4.tar.bz2"
    sha256   "07f864654561e4ac8629a0ef9c8f07fbc1f8592d1b6c418431593e9ba2cf2fcf"
  end

  resource "libxkbfile" do
    url      "http://ftp.x.org/pub/individual/lib/libxkbfile-1.0.9.tar.bz2"
    sha256   "51817e0530961975d9513b773960b4edd275f7d5c72293d5a151ed4f42aeb16a"
  end

  resource "libxshmfence" do
    url      "http://ftp.x.org/pub/individual/lib/libxshmfence-1.2.tar.bz2"
    sha256   "d21b2d1fd78c1efbe1f2c16dae1cb23f8fd231dcf891465b8debe636a9054b0c"
  end

  resource "xtrans" do
    url      "http://ftp.x.org/pub/individual/lib/xtrans-1.3.5.tar.bz2"
    sha256   "adbd3b36932ce4c062cd10f57d78a156ba98d618bdb6f50664da327502bc8301"
  end





  def install

# util-macros
    resource("util-macros").stage do
      system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{prefix}/etc", "--localstatedir=#{prefix}/var", "--disable-static"
      system "make", "install"
    end

# Xorg Protocol Headers
    res = %w[bigreqsproto compositeproto damageproto dmxproto dri2proto dri3proto fixesproto fontsproto glproto inputproto kbproto presentproto randrproto recordproto renderproto resourceproto scrnsaverproto videoproto xcmiscproto xextproto xf86bigfontproto xf86dgaproto xf86driproto xf86vidmodeproto xineramaproto xproto]

    res.each do |r|
      resource(r).stage do
        system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{prefix}/etc", "--localstatedir=#{prefix}/var", "--disable-static"
        system "make", "install"
      end
    end

#   ENV.append_path "PATH",                "#{prefix}/bin"
    ENV.append_path "PKG_CONFIG_PATH",     "#{prefix}/lib/pkgconfig"   # xcb-proto is there 
    ENV.append_path "PKG_CONFIG_PATH",     "#{prefix}/share/pkgconfig" # xorg-macros is there
#   ENV.append_path "LIBRARY_PATH",        "#{prefix}/lib"
#   ENV.append_path "C_INCLIDE_PATH",      "#{prefix}/include"
#   ENV.append_path "CPLUS_INCLUDE_PATH",  "#{prefix}/include"

    mkdir_p lib
    ln_s lib, "#{prefix}/lib64"

# libXdmcp
    resource("libXdmcp").stage do
      system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{prefix}/etc", "--localstatedir=#{prefix}/var", "--disable-static"
      system "make"
      system "make", "install"
    end


# libXau
    resource("libXau").stage do
      system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{prefix}/etc", "--localstatedir=#{prefix}/var", "--disable-static" 
      system "make"
      system "make", "check"
      system "make", "install"
    end

# xcb-proto
    resource("xcb-proto").stage do
      system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{prefix}/etc", "--localstatedir=#{prefix}/var", "--disable-static"
      system "make", "check"
      system "make", "install"
    end

### libpthread-stubs
### see inreplace below 
##    resource("libpthread-stubs").stage do
##      system "./configure", "--prefix=#{prefix}"
##      system "make"
##      system "make", "install"
##    end

# libxcb
    resource("libxcb").stage do
      inreplace "configure", /pthread-stubs/, ""
      system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{prefix}/etc", "--localstatedir=#{prefix}/var", "--disable-static",
                            "--enable-xinput" # , "--without-doxygen"

      system "make"
      system "make", "install"
    end

 
    res = %w[xtrans libX11 libXext libFS libICE libSM libXScrnSaver libXt libXmu libXpm libXaw libXfixes libXcomposite libXrender libXcursor libXdamage libfontenc libXfont libXft libXi libXinerama libXrandr libXres libXtst libXv libXvMC libXxf86dga libXxf86vm libdmx libpciaccess libxkbfile libxshmfence]

    res.each do |r|
      resource(r).stage do

      case r 
      when "libXfont"
        system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{prefix}/etc", "--localstatedir=#{prefix}/var", "--disable-static", "--disable-devel-docs"
      when "libXt"
        system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{prefix}/etc", "--localstatedir=#{prefix}/var", "--disable-static", "--with-appdefaultdir=#{prefix}/X11/app-defaults"
      else
        system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{prefix}/etc", "--localstatedir=#{prefix}/var", "--disable-static"
      end

        system "make"
        system "make", "install"
        system "ldconfig"
      end
    end
  end

end
