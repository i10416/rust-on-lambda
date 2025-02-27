{
  description = "Rust on Lambda";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  inputs.rust-overlay = {
    url = "github:oxalica/rust-overlay";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      rust-overlay,
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        { pkgs, system, ... }:
        let
          overlays = [ (import rust-overlay) ];
          pkgs = import nixpkgs {
            inherit system overlays;
            config.allowUnfree = true;
          };
          toolchain = (pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain).override {
            extensions = [ "rust-src" ];
          };
        in
        {
          devShells = {
            default = pkgs.mkShell {
              name = "Rust on Lambda";
              inputsFrom = with pkgs; [
                libaom
              ];
              buildInputs = with pkgs; [
                # Infrastructure
                terraform
                terraform-docs
                tflint
                awscli2
                ssm-session-manager-plugin
                minio
                aws-lambda-rie
                trivy
                # Rust
                toolchain
                cargo-lambda
                cargo-bloat
                taplo
                libavif
              ];
            };
          };
        };
    };
}
