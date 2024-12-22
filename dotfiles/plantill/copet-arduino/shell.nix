{
  pkgs ? import <nixpkgs> { },
  lib,
}:
let
  packages = with pkgs; [
	  arduino
	  arduino-cli
  ];
in
pkgs.mkShell {
  # Get dependencies from the main package
  nativeBuildInputs = packages;
  buildInputs = packages;
  env = {
    LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
    LD_LIBRARY_PATH = "${lib.makeLibraryPath packages}";
  };
}
