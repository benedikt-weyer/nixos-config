{
  description = "Nixos config flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.05";
      #url = "https://channels.nixos.org/nixos-25.05/nixexprs.tar.xz";
    };

    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      #url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = rec {
            inherit inputs;

            pkgs-unstable = import nixpkgs-unstable { 
              system = "x86_64-linux"; 
              config.allowUnfree = true; 
            };

            pkgs-custom = pkgs: {
              prisma-engines-up-to-date = pkgs.callPackage ./modules/custom-packages/prisma-engines/package.nix { 
                inherit pkgs pkgs-unstable; 
                lib = nixpkgs.lib;
              };
            };
          };
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
            }
            ./hosts/default/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = rec {
            inherit inputs;

            pkgs-unstable = import nixpkgs-unstable { 
              system = "x86_64-linux"; 
              config.allowUnfree = true; 
            };
            
            pkgs-custom = pkgs: {
              prisma-engines-up-to-date = pkgs.callPackage ./modules/custom-packages/prisma-engines/package.nix { 
                inherit pkgs pkgs-unstable; 
                lib = nixpkgs.lib;
              };
            };
          };
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = [
                (final: prev:
                {
                  # libfprint = prev.libfprint.overrideAttrs (old: {
                  #   src = builtins.fetchGit {
                  #     url = "https://gitlab.freedesktop.org/depau/libfprint.git";
                  #     ref = "elanmoc2";
                  #     rev = "f4439ce96b2938fea8d4f42223d7faea05bd4048";
                  #   };
                  # });

                  # fprintd = prev.fprintd.overrideAttrs (old: {
                  #   mesonCheckFlags = [
                  #     # PAM related checks are timing out
                  #     "--no-suite" "fprintd:TestPamFprintd" 
                  #     # Tests FPrintdManagerPreStartTests.test_manager_get_no_default_device & FPrintdManagerPreStartTests.test_manager_get_no_devices are failing
                  #     "--no-suite" "fprintd:FPrintdManagerPreStartTests"
                  #   ];
                  # });
                })
              ];
            }
            ./hosts/laptop/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
