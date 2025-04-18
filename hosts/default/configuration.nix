{
  config,
  pkgs,
  pkgs-unstable,
  pkgs-custom,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix

    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.printing.drivers = [
    (pkgs.writeTextDir "share/cups/model/canonts7400.ppd" (
      builtins.readFile ./../../modules/printer-drivers/canonts7400.ppd
    ))
    pkgs.cnijfilter2
  ];

  hardware.printers = {
    ensurePrinters = [
      {
        name = "TS7400-USB";
        location = "Home";
        deviceUri = "usb://Canon/TS7400%20series?serial=015DB2&interface=1";
        model = "canonts7400.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
  };

  hardware.sane.enable = true; # enables support for SANE scanners

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
    ];
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  hardware.nvidia-container-toolkit.enable = true;

  users.users.benedikt = {
    isNormalUser = true;
    description = "Benedikt Weyer";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "scanner" 
      "lp" 
    ];
    packages = with pkgs; [
      brave
      # alacritty
    ];
  };

  home-manager = {
    extraSpecialArgs = { 
      inherit inputs; 
      inherit pkgs-unstable;
      inherit pkgs-custom;
    };
    users = {
      "benedikt" = import ./home.nix;
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    cifs-utils

    pcsclite
    pcsc-tools
  ];

  services.pcscd.enable = true;

  system.stateVersion = "24.11";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  fileSystems."/mnt/Local_Share" = {
    device = "//nvme-nas.home.arpa/Local_Share";
    fsType = "cifs";
    options = [
      "credentials=/home/benedikt/secrets/.local-nas-credentials"
      "uid=1000"
      "gid=1000"
      "_netdev"
      "defaults"
    ];
  };

  fileSystems."/mnt/Backups" = {
    device = "//nvme-nas.home.arpa/Backups";
    fsType = "cifs";
    options = [
      "credentials=/home/benedikt/secrets/.local-nas-credentials"
      "uid=1000"
      "gid=1000"
      "_netdev"
      "defaults"
    ];
  };

  virtualisation.docker.enable = true;

}
