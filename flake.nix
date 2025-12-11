{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      devenv,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems =
        f: nixpkgs.lib.genAttrs systems (system: f system (import nixpkgs { inherit system; }));

      loadDevenv =
        lang: system: pkgs:
        let
          devenvFile = ./${lang}/devenv.nix;
        in
        devenv.lib.mkShell {
          inherit pkgs;
          modules = [ devenvFile ];
        };
    in
    {
      templates = {
        c = {
          description = "C devenv";
          path = ./c;
        };

        java = {
          description = "Java devenv";
          path = ./java;
        };

        python = {
          description = "Python devenv";
          path = ./python;
        };
      };

      devShells = forAllSystems (
        system: pkgs: {
          c = loadDevenv "c" system pkgs;
          java = loadDevenv "java" system pkgs;
          python = loadDevenv "python" system pkgs;
        }
      );

    };
}
