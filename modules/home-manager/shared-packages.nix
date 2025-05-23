{
  config,
  pkgs,
  pkgs-unstable,
  pkgs-custom,
  ...
}:

{
  home.packages = with pkgs; [
    pkgs-unstable.brave

    nerd-fonts.hack
    nerd-fonts.geist-mono
    nerd-fonts.jetbrains-mono
    roboto

    gnomeExtensions.dash-to-dock
    gnomeExtensions.night-theme-switcher
    gnomeExtensions.pop-shell
    gnomeExtensions.notification-timeout
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.mouse-follows-focus-2
    gnomeExtensions.pano
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
    pkgs-unstable.supabase-cli
 

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

    pkgs-unstable.rustdesk-flutter

    ledger-live-desktop
    pkgs-unstable.ausweisapp    

    insomnia
    direnv
    htop
    sysprof
    pkgs-unstable.protonvpn-gui
    pkgs-unstable.spotify
    tidal-hifi
    filezilla
    pkgs-unstable.xpipe
    pkgs-unstable.libreoffice-qt6-fresh
    pkgs-unstable.bitwig-studio
    fastfetch
    lsd
    pkgs-unstable.eduvpn-client
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

    pkgs-unstable.prisma-engines

    drawio

    pkgs-unstable.trivy

    pkgs-unstable.windsurf
    pkgs-unstable.code-cursor
    
    unigine-heaven
    unigine-valley
    unigine-superposition
    geekbench
  ];
}
