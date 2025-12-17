# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Copier template repository that generates project scaffolding with preferred configurations for JavaScript/TypeScript, PHP, Rust, and Rust+Android projects. The template uses Nix flakes for reproducible development environments.

## Repository Structure

- `template/` - The Copier template source (files with `.jinja` suffix are processed by Copier)
- `.config/` - Nix flake partitions for devshells and git-hooks (for developing *this* repository)
- `template/.config/` - Nix configuration files that become part of generated projects
- `.data/` - Local data/testing (gitignored, may contain example template implementations)
- `copier.yml` - Template configuration and prompts

## Development Commands

```bash
# Push to remotes (runs pre-commit first)
just push branch=main

# Manual pre-commit run
pre-commit

# Format with treefmt (in generated projects)
treefmt
```

## Key Concepts

- **Jinja templates**: Files ending in `.jinja` are processed by Copier. The `flake.nix.jinja` suffix is intentional even when files contain no Jinja syntax - this prevents direnv from treating `template/` as a flake root.
- **Nix flake partitions**: The main `flake.nix` uses `flake-parts` with partitions to separate dev tooling (in `.config/`) from the core flake outputs.
- **Pre-commit hooks**: Configured via git-hooks.nix, includes biome, markdownlint, reuse, treefmt, and yamllint.

## Template Variables

Defined in `copier.yml`:
- `prj_slug` - Project identifier
- `prj_title` - Human-readable project name
- `prj_repo_name` - Git forge repository name (defaults to slug)
- `langs` - Multi-select for JS/TS, PHP, Rust, Rust+Android

## Language-Specific Notes

### Rust+Android

Selecting "Rust+Android" implies Rust support (all `"rust" in langs` conditions are satisfied). This option adds:
- Android SDK/NDK via `androidenv.composeAndroidPackages`
- Rust toolchain with Android cross-compilation targets
- `cargo-ndk` for building Android libraries
- Gradle and JDK17 for Android builds
- `patch-gradle-aapt2` utility for NixOS compatibility
- FHS environment for running Android build tools
- Just commands for Android build/deploy workflow

The devshell uses the `devshelves` flake module (provides `shells.default` pattern with cleaner env var handling) instead of standard `devShells.default`.
