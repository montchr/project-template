{
  perSystem =
    {
      config,
      inputs',
      pkgs,
      ...
    }:
    let
      commonPkgs = [
        inputs'.nixpkgs-trunk.legacyPackages.just
        pkgs.reuse
      ];

      checksPkgs = config.pre-commit.settings.enabledPackages ++ [
        pkgs.biome
      ];

      formatterPkgs = [
        config.formatter
        pkgs.biome
        pkgs.taplo
        pkgs.treefmt
      ];

      ciPkgs = commonPkgs ++ checksPkgs;
      devPkgs = commonPkgs ++ checksPkgs ++ formatterPkgs;
    in
    {
      devShells.default = pkgs.mkShellNoCC {
        shellHook = ''
          : "''${PRJ_BIN_HOME:=''${PRJ_PATH:-''${PRJ_ROOT}/.bin}}"

          export PRJ_BIN_HOME

          ${config.pre-commit.installationScript}
        '';
        nativeBuildInputs = devPkgs;
      };

      devShells.ci = pkgs.mkShellNoCC { nativeBuildInputs = ciPkgs; };
    };
}
