{ config, pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          #"fzf-tab"
          #"fzf"
          #"zsh-autosuggestions"
          "sudo"
          "web-search"
          #"zsh-syntax-highlighting"
          #"fast-syntax-highlighting"
          "copypath"
          "copyfile"
          "copybuffer"
          "dirhistory"
          "jsontools"
        ];
      };

      shellAliases = {
        ll = "ls -l";
        update = "sudo nix flake update --flake /etc/nixos/";
        rebuild = "sudo nixos-rebuild switch --flake /etc/nixos/#default";
        edit-home = "nvim /etc/nixos/default/home.nix";
        edit-conf = "nvim /etc/nixos/default/configuration.nix";
        edit-hconf = "nvim /etc/nixos/default/hardware-configuration.nix";
        edit-flake = "nvim /etc/nixos/flake.nix";
        ff = "fastfetch";
        ls = "lsd -a";
      };

      initExtra = with pkgs; ''
        export PRISMA_SCHEMA_ENGINE_BINARY="${prisma-engines}/bin/schema-engine"
        export PRISMA_QUERY_ENGINE_BINARY="${prisma-engines}/bin/query-engine"
        export PRISMA_QUERY_ENGINE_LIBRARY="${prisma-engines}/lib/libquery_engine.node"
        export PRISMA_INTROSPECTION_ENGINE_BINARY="${prisma-engines}/bin/introspection-engine"
        export PRISMA_FMT_BINARY="${prisma-engines}/bin/prisma-fmt"
      '';
    };
    
  };
}