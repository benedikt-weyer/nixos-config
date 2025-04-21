{ 
  config, 
  pkgs,
  pkgs-unstable,
  ... 
}:

{
  programs = {
    vscode = {
      enable = true;
      package = pkgs-unstable.vscode.fhs;
      # extensions = with pkgs.vscode-marketplace; with pkgs.vscode-marketplace-release; [
      #   vscjava.vscode-java-pack
      #   redhat.java
      #   vscjava.vscode-java-debug
      #   vscjava.vscode-java-test
      #   vscjava.vscode-maven
      #   vscjava.vscode-java-dependency
      #   vscjava.vscode-gradle
      #   esbenp.prettier-vscode
      #   github.copilot
      #   github.copilot-chat
      #   jnoortheen.nix-ide
      #   brettm12345.nixfmt-vscode
      #   mkhl.direnv
      #   eamodio.gitlens
      #   ms-azuretools.vscode-docker
      #   albert.tabout

      # ];
      # userSettings = {
      #   "git.confirmSync" = false;

      #   "[json]" = {
      #     "editor.defaultFormatter" = "esbenp.prettier-vscode";
      #   };

      #   "editor.formatOnSave" = true;
      #   "editor.wordWrap" = "on";
      #   "editor.fontFamily" = "'JetBrainsMono NFM'";
      #   "editor.fontSize" = 14;
      #   "editor.fontLigatures" = true;

      #   "terminal.integrated.fontFamily" = "'GeistMono NFM'";
      #   "terminal.integrated.fontSize" = 14;
      #   "terminal.integrated.defaultProfile.linux" = "zsh";
      #   "terminal.integrated.profiles.linux" = {
      #     zsh = {
      #       path = "${pkgs.zsh}/bin/zsh";
      #     };
      #   };
      # };
    };
    
  };
}