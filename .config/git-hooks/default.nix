{
  perSystem =
    { config, pkgs, ... }:
    {
      pre-commit.settings = {
        hooks = {
          biome.enable = true;
          markdownlint.enable = true;
          markdownlint.excludes = [
            # Auto-generated
            "CHANGELOG.md"
          ];
          treefmt.enable = true;
          yamllint.enable = true;
          yamllint.excludes = [
            ".copier-answers.yml"
          ];
        };
        default_stages = [
          "pre-commit"
          "pre-push"
        ];
        excludes = [ ];
      };
    };
}
