{ 
  config, 
  pkgs,
  pkgs-custom,
  ... 
}:

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
        
        update-etc = "sudo nix flake update --flake /etc/nixos/";
        update = "sudo nix flake update --flake ~/nixos-config";

        ff = "fastfetch";
        ls = "lsd -a";
      };

      initExtra = with pkgs-custom; ''
        export PRISMA_SCHEMA_ENGINE_BINARY="${prisma-engines-up-to-date}/bin/schema-engine"
        export PRISMA_QUERY_ENGINE_BINARY="${prisma-engines-up-to-date}/bin/query-engine"
        export PRISMA_QUERY_ENGINE_LIBRARY="${prisma-engines-up-to-date}/lib/libquery_engine.node"
        export PRISMA_INTROSPECTION_ENGINE_BINARY="${prisma-engines-up-to-date}/bin/introspection-engine"
        export PRISMA_FMT_BINARY="${prisma-engines-up-to-date}/bin/prisma-fmt"
      '';
    };
    
  };
}
