{
  config,
  pkgs,
  ...
}:
{
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
    php
    php82Packages.composer
    gcc
    symfony-cli
 

    gnome-extension-manager
    dconf-editor
    desktop-file-utils
    gnome-tweaks
    ffmpeg
    mesa
    mesa-demos
    freeglut
    vlc
    xournalpp
    gdmap
    zip

    shotcut
    obs-studio

    rustdesk

    ledger-live-desktop
    ausweisapp    

    insomnia
    direnv
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
    
    anki
    
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

  ];
}
