{ pkgs, ... }:

{
  languages.java = {
    enable = true;
    jdk.package = pkgs.jdk25.override {
      enableJavaFX = true;
      openjfx_jdk = pkgs.javaPackages.openjfx25;
    };
    maven = true;
  };
}
