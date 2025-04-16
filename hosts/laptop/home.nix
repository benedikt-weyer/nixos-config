{
  config,
  pkgs,
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
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.nix-vscode-extensions.overlays.default

      ( final: _prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = final.system;
          config.allowUnfree = true;
        };
      })
    ];
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "benedikt";
  home.homeDirectory = "/home/benedikt";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".ssh/config_source" = {
        source = ../../modules/config-files/ssh-config;
        onChange = "cat ~/.ssh/config_source > ~/.ssh/config && chmod 600 ~/.ssh/config";
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/benedikt/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  # Let Home Manager install and manage itself.
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
