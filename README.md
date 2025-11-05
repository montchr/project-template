# Thee Project Template

This is a Copier template that aims to provide a set of preferred
configurations for development tools in the various languages and
development environments I work with.

Most of the configuration files will be common to all projects
(e.g. `.editorconfig`), but some files are only necessary based on
project type (e.g. all projects with JavaScript/TypeScript code will
have a `tsconfig.json` file, but a Rust-only project will not have need
of this file so it will be omitted).  These conditions are to be
determined by way of the Copier answers.

## Development

Note that the template’s `flake.nix` files should always have a `.jinja`
suffix regardless of whether they contain Jinja syntax.  This prevents
Direnv and tools that look for the presence of a `flake.nix` file from
thinking that the `template/` subdirectory is a real root scope.
Without it, you would likely experience errors when the Nix development
shell is initialized.
