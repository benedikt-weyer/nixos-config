{
  description = "Nixos config flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };

    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";

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
          specialArgs = { 
            inherit inputs; 
            pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
            pkgs-unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
          };
          modules = [
            ./hosts/default/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { 
            inherit inputs; 
            pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
            pkgs-unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
          };
          modules = [
            ./hosts/laptop/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
