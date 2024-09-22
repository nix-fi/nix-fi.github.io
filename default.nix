{
  sources ? import ./npins,
  system ? builtins.currentSystem,
  pkgs ? import sources.nixpkgs {
    inherit system;
    config = { };
    overlays = [ ];
  },
}:
rec {
  web = pkgs.stdenv.mkDerivation {
    name = "website";
    src = ./.; # TODO clean source
    # configurePhase = ''
    #   mkdir -p "themes/${themeName}"
    #   cp -r ${deepthought}/* "themes/${themeName}"
    # '';
    buildPhase = "${pkgs.lib.getExe pkgs.zola} build";
    installPhase = "cp -r public $out";
  };
  shell = pkgs.mkShellNoCC {
    # inputsFrom = [ web ];
    packages = with pkgs; [
      npins
      zola
    ];
  };
}
