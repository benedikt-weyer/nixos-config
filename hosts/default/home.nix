{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
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

  home.packages = with pkgs; [
    nvtopPackages.nvidia
  ];

  home.file = {
    
  };

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  programs.home-manager.enable = true;

  programs = {  
    gpg.enable = true;
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "clipboard-indicator@tudmotu.com"
        "nightthemeswitcher@romainvigier.fr"
        "pop-shell@system76.com"
        "notification-timeout@codito.github.com"
        "tray-icons-reloaded@selfmade.pl"
        "pomodoro@arun.codito.in"
        "mouse-follows-focus@crisidev.org"
      ];
    };

    "org/gnome/shell/extensions/pop-shell" = {
      "active-hint" = false;
      "active-hint-border-radius" = 6;
      "tile-by-default" = true;
      "gap-inner" = 1;
      "gap-outer" = 1;
      "show-skip-taskbar" = true;
      "show-title" = true;
      "stacking-with-mouse" = false;
      "focus-left" = [ "<Super><Shift>Left" ];
      "focus-right" = [ "<Super><Shift>Right" ];
      "pop-monitor-left" = [ "<Super><Control>Left" ];
      "pop-monitor-right" = [ "<Super><Control>Right" ];
      "smart-gaps" = true;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      "dock-fixed" = true;
      "extend-height" = true;
      "multi-monitor" = true;
      "force-straight-corner" = true;
      "always-center-icons" = true;
      "show-show-apps-button" = false;
      "dash-max-icon-size" = 32;
      "custom-theme-shrink" = true;
      "custom-theme-running-dots" = true;
      "running-indicator-style" = "DOTS";
    };

    "org/gnome/shell/extensions/clipboard-indicator" = {
      "toggle-menu" = "<Super>v";
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>x" ];
      switch-to-workspace-left = [ "<Super>Left" ];
      switch-to-workspace-right = [ "<Super>Right" ];
      move-to-workspace-left = [ "<Super><Alt>Left" ];
      move-to-workspace-right = [ "<Super><Alt>Right" ];
      move-to-monitor-left = [ ];
      move-to-monitor-right = [ ];

      toggle-tiled-left = [ ];
      toggle-tiled-right = [ ];
      move-to-side-e = [ ];
      move-to-side-w = [ ];
      toggle-message-tray = [ ];
    };

    "org/gnome/desktop/input-sources" = {
      "xkb-options" = [ "lv3:caps_switch" "shift:both_shiftlock" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      "focus-mode" = "sloppy";
      "button-layout" = "appmenu:minimize,maximize,close";
      "num-workspaces" = 7;
      "workspace-names" = [ "Time & Task planning" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      "custom-keybindings" = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      "binding" = "<Super>c";
      "command" = "${pkgs.alacritty}/bin/alacritty";
      "name" = "Launch Alacritty";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      "binding" = "<Super>f";
      "command" = "nautilus";
      "name" = "Open File Manager";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      "binding" = "<Super>b";
      "command" = "brave";
      "name" = "Open Browser";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      "sleep-inactive-ac-timeout" = 0;
      "sleep-inactive-battery-timeout" = 0;
      "sleep-inactive-ac-type" = "nothing";
      "sleep-inactive-battery-type" = "nothing";
    };
    "org/gnome/desktop/session" = {
      "idle-delay" = lib.hm.gvariant.mkUint32 (0);
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  fonts.fontconfig.enable = true;
}
