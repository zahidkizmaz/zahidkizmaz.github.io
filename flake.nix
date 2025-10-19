{
  description = "Nix flake using flake-parts for building and running a Zola static website";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    theme-tabi = {
      url = "github:zahidkizmaz/tabi/cleanup/remove-stuff";
      flake = false;
    };
    self.submodules = true;
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, system, ... }:
        let
          webisePackage = pkgs.stdenv.mkDerivation rec {
            pname = "website";
            version = "2025-10-18";
            src = ./.;
            nativeBuildInputs = with pkgs; [
              gitMinimal
              zola
            ];

            buildPhase = ''
              zola build
            '';

            installPhase = ''
              mkdir -p $out/bin
              cp -r public $out/
              echo '#!${pkgs.runtimeShell}' > $out/bin/${pname}
              echo "exec ${pkgs.zola}/bin/zola serve" >> $out/bin/${pname}
              chmod +x $out/bin/${pname}
            '';
          };
        in
        {
          packages = {
            website = webisePackage;
            default = webisePackage;
          };

          devShells = {
            default = pkgs.mkShell {
              packages = with pkgs; [
                pre-commit
                zola
              ];
              shellHook = ''
                pre-commit install
                git submodule update --init --recursive
              '';
            };
          };
        };
    };
}
