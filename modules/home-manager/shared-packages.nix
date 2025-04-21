{
  config,
  pkgs,
  pkgs-unstable,
  pkgs-custom,
  ...
}:

{
  home.packages = with pkgs; [
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
    pkgs-unstable.ausweisapp    

    insomnia
    direnv
    htop
    sysprof
    protonvpn-gui
    spotify
    filezilla
    xpipe
    libreoffice
    pkgs-unstable.bitwig-studio
    fastfetch
    lsd
    eduvpn-client
    nixfmt-rfc-style
    obsidian

    alacritty-theme
    wl-clipboard
    poppler_utils
    
    anki
    
    android-tools
    android-udev-rules
    libarchive
    usbutils

    pkgs-custom.prisma-engines-up-to-date

    drawio
  ];
}
