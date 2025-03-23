{ config, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;

      extraConfig = {
        commit.gpgsign = true;
        gpg.format = "openpgp";
        user.signingkey = "09E2C230A7CCCBF5";
        user.name = "Benedikt Weyer";
        user.email = "bw.development@pm.me";
        pull.rebase = true;
        core.editor = "code --wait";
        core.autocrlf = "input";
        init.defaultBranch = "main";
        diff.tool = "vscode";
        difftool.vscode.cmd = "code --wait --diff $LOCAL $REMOTE";
        alias.co = "checkout";
        alias.br = "branch";
        alias.ci = "commit";
        alias.st = "status";
        alias.lg = "log --oneline --all --graph";
      };
    };
    
  };
}