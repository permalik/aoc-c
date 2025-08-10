{
  description = "aoc-c";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        name = "aoc-c";
        src = ./.;
        pkgs = nixpkgs.legacyPackages.${system};
        # buildInputs = with pkgs; [clang-tools];
        nativeBuildInputs = with pkgs; [clang-tools glibc];
      in {
        packages = {
          default = let
            inherit (pkgs) clangStdenv;
          in
            clangStdenv.mkDerivation {
              name = "aoc-c";
              src = pkgs.lib.cleanSource ./.;
              enableDebugging = true;
              dontStrip = true;
              # buildInputs = with pkgs; [];

              buildPhase = with pkgs; ''
                clang -g -O0 -pg -fno-standalone-debug ./src/main.c -o aoc-c
              '';

              installPhase = ''
                mkdir -p $out/bin
                cp aoc-c $out/bin/aoc-c
              '';
            };
        };

        devShells.default = pkgs.mkShell.override {stdenv = pkgs.clangStdenv;} {
          packages = with pkgs; [pkg-config clang-tools glibc alejandra pre-commit];
          inputsFrom = [self.packages.${system}.default];
          # buildInputs = [
          #   pkgs.alejandra
          #   pkgs.gcc
          #   pkgs.gnumake
          #   pkgs.pkg-config
          #   pkgs.llvmPackages_19.clang-tools
          #   pkgs.pre-commit
          #   # pkgs.gdb
          #   # pkgs.valgrind
          # ];

          shellHook = with pkgs; ''
            # Source .bashrc
            . .bashrc
          '';
        };
      }
    );
}
