{
  pkgs ? import <nixpkgs> { },
  lib ? pkgs.lib,
}:
let
  packages = with pkgs; [
    rust-analyzer
    rustfmt
    clippy
    mold
    rustup # mostly for rustup doc

    #wayland
    #xorg.libX11
    #xorg.libXcursor
  ];
in
pkgs.mkShell {
  # Get dependencies from the main package
  inputsFrom = [ (pkgs.callPackage ./default.nix { }) ];
  nativeBuildInputs = packages;
  buildInputs = packages;
  env = {
    LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
    LD_LIBRARY_PATH = "${lib.makeLibraryPath packages}";
  };
}
