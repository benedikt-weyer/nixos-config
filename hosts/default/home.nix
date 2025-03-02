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
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    #  pkgs.nodePackages.graphql-language-service-cli
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (nerdfonts.override {
      fonts = [
        "Hack"
        "GeistMono"
        "JetBrainsMono"
      ];
    })
    roboto

    gnomeExtensions.dash-to-dock
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.night-theme-switcher
    gnomeExtensions.pop-shell
    gnomeExtensions.notification-timeout
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.mouse-follows-focus-2
    gnome-pomodoro

    nodejs_22
    pnpm_10
    bun
    jdk
postgresql_17

    gnome-extension-manager
    dconf-editor
    desktop-file-utils
    gnome-tweaks

    insomnia
    direnv
    nvtopPackages.nvidia
    htop
    sysprof
    protonvpn-gui
    spotify
    filezilla
    xpipe
    libreoffice
    bitwig-studio
    fastfetch
    lsd
    eduvpn-client
    nixfmt-rfc-style
    obsidian

    alacritty-theme
    wl-clipboard
poppler_utils

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

  ];

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
    nixvim = {
      enable = true;

      colorschemes.gruvbox.enable = true;

      plugins = {
        lualine.enable = true;
        telescope.enable = true;
        oil.enable = true;
        treesitter.enable = true;
        luasnip.enable = true;
        web-devicons.enable = true;
      };
    };

    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
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

    alacritty = {
      enable = true;
      settings = {
        general.import = [ ".nix-profile/catppuccin_macchiato.toml" ];
        terminal.shell = {
          program = "${pkgs.zsh}/bin/zsh";
        };
        window = {
          opacity = 0.7;
        };
        font = {
          normal = {
            family = "GeistMono NFM";
            style = "Regular";
          };
          bold = {
            family = "GeistMono NFM";
            style = "Bold";
          };
          italic = {
            family = "GeistMono NFM";
            style = "Italic";
          };
          size = 12;
        };
        mouse.hide_when_typing = false;
      };
    };

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
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      defaultOptions = [
        "--height 40%"
        "--layout=reverse"
        "--border"
        "--info=inline"
      ];
      fileWidgetCommand = "fd --type f";
      fileWidgetOptions = [
        "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
      ];
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      #settings = {
      #  add_newline = false;
      #  character = {
      #    success_symbol = "[➜](bold green)";
      #    error_symbol = "[✗](bold red)";
      #  };
      #  package.disabled = false;
      #  nodejs.disabled = false;
      #  python.disabled = false;
      #};
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";
        format =
          "[](color_orange)$os$username[](bg:color_yellow fg:color_orange)$directory[](fg:color_yellow bg:color_aqua)$git_branch$git_status"
          + "[](fg:color_aqua bg:color_blue)$c$rust$golang$nodejs$php$java$kotlin$haskell$python[](fg:color_blue bg:color_bg3)$docker_context"
          + "$conda[](fg:color_bg3 bg:color_bg1)$time[ ](fg:color_bg1)$line_break$character";

        palette = "gruvbox_dark";

        palettes.gruvbox_dark = {
          color_fg0 = "#fbf1c7";
          color_bg1 = "#3c3836";
          color_bg3 = "#665c54";
          color_blue = "#458588";
          color_aqua = "#689d6a";
          color_green = "#98971a";
          color_orange = "#d65d0e";
          color_purple = "#b16286";
          color_red = "#cc241d";
          color_yellow = "#d79921";
        };

        os = {
          disabled = false;
          style = "bg:color_orange fg:color_fg0";
        };

        username = {
          show_always = true;
          style_user = "bg:color_orange fg:color_fg0";
          style_root = "bg:color_orange fg:color_fg0";
          format = "[ $user ]($style)";
        };

        directory = {
          style = "fg:color_fg0 bg:color_yellow";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = "󰝚 ";
            "Pictures" = " ";
            "Developer" = "󰲋 ";
          };
        };

        git_branch = {
          symbol = "";
          style = "bg:color_aqua";
          format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
        };

        git_status = {
          style = "bg:color_aqua";
          format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
        };

        nodejs = {
          symbol = "";
          style = "bg:color_blue";
          format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        };

        c = {
          symbol = " ";
          style = "bg:color_blue";
          format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        };

        rust = {
          symbol = "";
          style = "bg:color_blue";
          format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        };

        golang = {
          symbol = "";
          style = "bg:color_blue";
          format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        };

        php = {
          symbol = "";
          style = "bg:color_blue";
          format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        };

        java = {
          symbol = "";
          style = "bg:color_blue";
          format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        };

        kotlin = {
          symbol = "";
          style = "bg:color_blue";
          format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        };

        haskell = {
          symbol = "";
          style = "bg:color_blue";
          format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        };

        python = {
          symbol = "";
          style = "bg:color_blue";
          format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        };

        docker_context = {
          symbol = "";
          style = "bg:color_bg3";
          format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
        };

        conda = {
          style = "bg:color_bg3";
          format = "[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)";
        };

        time = {
          disabled = false;
          time_format = "%R";
          style = "bg:color_bg1";
          format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
        };

        line_break = {
          disabled = true;
        };

        character = {
          disabled = false;
          success_symbol = "[](bold fg:color_green)";
          error_symbol = "[](bold fg:color_red)";
          vimcmd_symbol = "[](bold fg:color_green)";
          vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
          vimcmd_replace_symbol = "[](bold fg:color_purple)";
          vimcmd_visual_symbol = "[](bold fg:color_yellow)";
        };
      };
    };

    gpg.enable = true;

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
      "xkb-options" = [ "lv3:caps_switch" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      "focus-mode" = "sloppy";
      "button-layout" = "appmenu:minimize,maximize,close";
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
