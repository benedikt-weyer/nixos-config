{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  inputs,
  ...
}:

{
  imports = [
    # For home-manager
    inputs.nixvim.homeManagerModules.nixvim

    ./../../modules/home-manager/programs/firefox.nix
    ./../../modules/home-manager/programs/starship.nix
    ./../../modules/home-manager/programs/alacritty.nix
    ./../../modules/home-manager/programs/zsh.nix
    ./../../modules/home-manager/programs/vscode.nix
    ./../../modules/home-manager/programs/nixvim.nix
    ./../../modules/home-manager/programs/git.nix
    ./../../modules/home-manager/programs/fzf.nix

    ./../../modules/home-manager/shared-packages.nix

    ./../../modules/home-manager/shared-files.nix

    ./../../modules/home-manager/shared-dconf-settings.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];
  };

  home.username = "benedikt";
  home.homeDirectory = "/home/benedikt";

  home.stateVersion = "24.11";

  home.sessionVariables = {
    # EDITOR = "emacs";
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  home.packages = with pkgs; [
    pkgs-unstable.easyroam-connect-desktop
  ];

  programs.home-manager.enable = true;

  programs = {  
    gpg.enable = true;
  };

  programs.zsh.shellAliases = {
      rebuild-etc = "sudo nixos-rebuild switch --flake /etc/nixos/#laptop";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config/#laptop";
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  fonts.fontconfig.enable = true;
}
