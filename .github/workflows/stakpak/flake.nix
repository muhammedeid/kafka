{
  description = "Stakpak Agent CI tools";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { 
            inherit system; 
            config.allowUnfree = true;
      };
    in {
      packages.${system}.stakpak-tools = pkgs.symlinkJoin {
        name = "stakpak-tools";
        paths = with pkgs; [
          # cloud/iac
          awscli2
          azure-cli
          google-cloud-sdk
          terraform
          # opentofu # alternative if you want drop-in replacement
          sops
          age

          # k8s
          kubectl
          helm
          k9s

          # containers
          docker             # client, talks to GitHub runner's daemon
          docker-compose

          # misc devtools
          gh
          jq
          yq
          just
          coreutils
          curl
        ];
      };
    };
}