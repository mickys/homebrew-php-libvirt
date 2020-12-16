require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Libvirt < AbstractPhp74Extension
  init
  desc "PHP bindings for libvirt virtualization toolkit"
  homepage "http://libvirt.org/php"
  url "http://libvirt.org/sources/php/libvirt-php-0.5.4.tar.gz"
  sha256 "1a755dee9f7de6831c17a871aec525bc6edebf5d6e375fcfff14c174d82c2129"

  # 0.5.4 tested on Catalina
  # 0.5.5 build errors
  # url "http://libvirt.org/sources/php/libvirt-php-0.5.4.tar.gz"
  # sha256 "26767a22e2eda972c31dcbb100c576be39624e103b747529d5740b4a4e9a2f48"


  depends_on "pkg-config" => :build
  depends_on "libvirt"
  depends_on "automake"

  def install
    #ENV.universal_binary if build.universal?
    system "sed -i -e 's/tools src docs tests/src/g' Makefile.am"
    system "sed -i -e 's/$(VERSION_SCRIPT_FLAGS)$(LIBVIRT_PHP_SYMBOL_FILE)/$(VERSION_SCRIPT_FLAGS)/g' src/Makefile.am"
    system "aclocal"
    system "automake"
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "src/.libs/libvirt-php.so" => "libvirt.so"
    write_config_file if build.with? "config-file"
  end
end
