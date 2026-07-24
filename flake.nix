{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devkitNix.url = "github:bandithedoge/devkitNix";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      devkitNix,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devkitNix.overlays.default ];
        };
      in
      {
        devShells.default = pkgs.mkShell.override { stdenv = pkgs.devkitNix.stdenvA64; } {
          buildInputs = [
            pkgs.pkg-config
          ];
          shellHook = ''
            export SYSROOT="${pkgs.devkitNix.devkitA64}"
            export PKG_CONFIG="${pkgs.pkg-config}/bin/pkg-config"
            export PKG_CONFIG_LIBDIR="$DEVKITPRO/portlibs/switch/lib/pkgconfig"
            export PKG_CONFIG_SYSROOT_DIR="$SYSROOT"
          '';
        };
        packages.default = pkgs.devkitNix.stdenvA64.mkDerivation {
          name = "devkitA64-example";
          src = ./.;

          makeFlags = [ "TARGET=example" ];
          installPhase = ''
            mkdir $out
            cp example.nro $out
          '';
        };
      }
    );
}
