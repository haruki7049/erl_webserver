{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;
        buildRebar3 = pkgs.beam.packages.erlang_26.buildRebar3;

        erl_webserver = buildRebar3 {
          name = "erl_webserver";
          version = "dev";
          src = lib.cleanSource ./.;
        };
      in
      {
        packages = {
          inherit erl_webserver;
          default = erl_webserver;
        };

        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.nixfmt-rfc-style
            pkgs.beam.interpreters.erlang_26
            pkgs.rebar3
          ];

          shellHook = ''
            export PS1="\n[nix-shell\w]$ "
          '';
        };
      }
    );
}
