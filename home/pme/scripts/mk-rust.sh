#!/usr/bin/env bash

# Exit immediately if any command fails
set -e

if [ -z "$1" ]; then
  echo "Error: Please provide a project name."
  echo "Usage: mk-rust <project-name>"
  exit 1
fi

PROJECT_NAME="$1"

if [ -d "$PROJECT_NAME" ]; then
  echo "Error: Directory '$PROJECT_NAME' already exists."
  exit 1
fi

echo "🧱 Creating directory structures for '$PROJECT_NAME'..."
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

echo "🐙 Initialising Git repository..."
git init

echo "📦 Bootstrapping Cargo natively via ephemeral Nix environment..."
nix shell nixpkgs#cargo --command cargo init --bin .

echo "❄️  Generating pristine, zero-dependency development flake.nix..."
cat <<'EOF' >flake.nix
{
  description = "A highly optimised development environment for Rust";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSystem = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in {
      devShells = forEachSystem (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            # Core compilation toolchain
            cargo
            rustc

            # Development utilities & Neovim integrations
            rust-analyzer
            clippy
            rustfmt
            cargo-watch
          ];
        };
      });
    };
}
EOF

echo "🚀 Wiring up Direnv hooks..."
echo "use flake" >.envrc

# Allow direnv to evaluation-cache the environment instantly
if command -v direnv &>/dev/null; then
  direnv allow
fi

echo "✅ Success! Project '$PROJECT_NAME' is ready."
echo "   Run 'tmx $PROJECT_NAME' to jump straight into your new workspace."
